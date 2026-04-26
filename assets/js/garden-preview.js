/**
 * Garden Preview Popover
 *
 * Shows an inline preview when the user interacts with a /garden/* link.
 * Desktop: hover to show, mouseout to dismiss (with delay so user can enter popover).
 * Mobile:  tap to show (prevents navigation), tap outside to dismiss.
 *          "Read full note →" navigates.
 *
 * NOTE: The theme's default.html has a global click handler on all <a> tags
 * that does preventDefault + 300ms bounce animation. We use capture-phase
 * event listeners to intercept garden links before that handler fires.
 */
(function () {
  'use strict';

  var HOVER_IN_DELAY  = 200;
  var HOVER_OUT_DELAY = 300;
  var POPOVER_MAX_W   = 350;
  var ARROW_SIZE      = 8;

  var gardenData = null;
  var activePopover = null;
  var activeLink = null;
  var hoverInTimer  = null;
  var hoverOutTimer = null;
  var isTouch = false;

  // ── Detect input mode ──────────────────────────────────────────────
  function detectTouch() {
    isTouch = !window.matchMedia('(hover: hover) and (pointer: fine)').matches;
  }

  // ── Fetch garden data ──────────────────────────────────────────────
  function loadData(cb) {
    if (gardenData) return cb(gardenData);
    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/assets/garden-data.json', true);
    xhr.onload = function () {
      if (xhr.status === 200) {
        try { gardenData = JSON.parse(xhr.responseText); } catch (e) { return; }
        cb(gardenData);
      }
    };
    xhr.send();
  }

  // ── Slug from href ─────────────────────────────────────────────────
  function slugFromHref(href) {
    var m = href.match(/\/garden\/([^/]+)\/?$/);
    return m ? m[1] : null;
  }

  // ── Maturity helpers ───────────────────────────────────────────────
  function maturityEmoji(m) {
    if (m === 'evergreen') return '🌳';
    if (m === 'budding')   return '🌿';
    return '🌱';
  }

  function maturityLabel(m) {
    if (m === 'evergreen') return 'Evergreen';
    if (m === 'budding')   return 'Budding';
    return 'Seedling';
  }

  // ── Build popover DOM ──────────────────────────────────────────────
  function createPopover(note) {
    var el = document.createElement('div');
    el.className = 'garden-popover';
    el.setAttribute('role', 'tooltip');

    var isDark = document.documentElement.classList.contains('dark');

    el.style.cssText = [
      'position:absolute',
      'z-index:9999',
      'max-width:' + POPOVER_MAX_W + 'px',
      'width:max-content',
      'padding:1rem 1.25rem',
      'border-radius:0.5rem',
      'box-shadow:0 8px 30px rgba(0,0,0,' + (isDark ? '0.5' : '0.15') + ')',
      'border:1px solid ' + (isDark ? '#404040' : '#e5e5e5'),
      'background:' + (isDark ? '#1c1c1c' : '#ffffff'),
      'color:' + (isDark ? '#e5e5e5' : '#262626'),
      'font-family:Mulish,sans-serif',
      'font-size:0.875rem',
      'line-height:1.5',
      'opacity:0',
      'transform:translateY(4px)',
      'transition:opacity 0.15s ease, transform 0.15s ease',
      'pointer-events:auto'
    ].join(';');

    // Arrow
    var arrow = document.createElement('div');
    arrow.className = 'garden-popover-arrow';
    arrow.style.cssText = [
      'position:absolute',
      'width:' + (ARROW_SIZE * 2) + 'px',
      'height:' + (ARROW_SIZE * 2) + 'px',
      'background:' + (isDark ? '#1c1c1c' : '#ffffff'),
      'border:1px solid ' + (isDark ? '#404040' : '#e5e5e5'),
      'transform:rotate(45deg)',
      'z-index:-1'
    ].join(';');
    el.appendChild(arrow);

    // Header: maturity + title
    var header = document.createElement('div');
    header.style.cssText = 'display:flex;align-items:center;gap:0.5rem;margin-bottom:0.5rem;';

    var badge = document.createElement('span');
    badge.textContent = maturityEmoji(note.maturity);
    badge.title = maturityLabel(note.maturity);
    badge.style.cssText = 'font-size:1rem;flex-shrink:0;';
    header.appendChild(badge);

    var title = document.createElement('strong');
    title.textContent = note.title;
    title.style.cssText = 'font-size:0.9375rem;color:' + (isDark ? '#f5f5f5' : '#171717') + ';';
    header.appendChild(title);
    el.appendChild(header);

    // Excerpt
    if (note.excerpt) {
      var excerpt = document.createElement('p');
      excerpt.textContent = note.excerpt;
      excerpt.style.cssText = 'margin:0 0 0.75rem 0;color:' + (isDark ? '#a3a3a3' : '#525252') + ';font-size:0.8125rem;line-height:1.55;';
      el.appendChild(excerpt);
    }

    // "Read full note" link
    var readLink = document.createElement('a');
    readLink.href = note.url;
    readLink.textContent = 'Read full note \u2192';
    readLink.className = 'garden-popover-link';
    readLink.style.cssText = [
      'display:inline-block',
      'font-size:0.8125rem',
      'font-weight:600',
      'color:' + (isDark ? '#67e8f9' : '#0891b2'),
      'text-decoration:none'
    ].join(';');
    readLink.addEventListener('mouseenter', function () { readLink.style.textDecoration = 'underline'; });
    readLink.addEventListener('mouseleave', function () { readLink.style.textDecoration = 'none'; });

    // Navigate directly — use capture to beat the theme's click interceptor
    readLink.addEventListener('click', function (e) {
      e.preventDefault();
      e.stopPropagation();
      e.stopImmediatePropagation();
      window.location.href = note.url;
    }, true);

    el.appendChild(readLink);

    return { el: el, arrow: arrow };
  }

  // ── Position the popover ───────────────────────────────────────────
  function positionPopover(popover, arrow, link) {
    document.body.appendChild(popover);
    popover.offsetHeight; // force layout

    var linkRect = link.getBoundingClientRect();
    var popRect  = popover.getBoundingClientRect();
    var scrollY  = window.pageYOffset || document.documentElement.scrollTop;
    var scrollX  = window.pageXOffset || document.documentElement.scrollLeft;
    var vw       = document.documentElement.clientWidth;
    var vh       = document.documentElement.clientHeight;

    var spaceBelow = vh - linkRect.bottom;
    var spaceAbove = linkRect.top;
    var placeBelow = spaceBelow >= popRect.height + ARROW_SIZE + 8 || spaceBelow >= spaceAbove;

    var top;
    if (placeBelow) {
      top = linkRect.bottom + scrollY + ARROW_SIZE + 4;
      arrow.style.top = -ARROW_SIZE + 'px';
      arrow.style.borderRight = 'none';
      arrow.style.borderBottom = 'none';
    } else {
      top = linkRect.top + scrollY - popRect.height - ARROW_SIZE - 4;
      arrow.style.top = (popRect.height - ARROW_SIZE) + 'px';
      arrow.style.borderLeft = 'none';
      arrow.style.borderTop = 'none';
    }

    // Horizontal: center on link, clamp to viewport
    var left = linkRect.left + scrollX + (linkRect.width / 2) - (popRect.width / 2);
    left = Math.max(scrollX + 8, Math.min(left, scrollX + vw - popRect.width - 8));

    popover.style.top = top + 'px';
    popover.style.left = left + 'px';

    // Arrow horizontal
    var arrowLeft = linkRect.left + scrollX + (linkRect.width / 2) - left - ARROW_SIZE;
    arrowLeft = Math.max(12, Math.min(arrowLeft, popRect.width - 24));
    arrow.style.left = arrowLeft + 'px';
  }

  // ── Show / hide ────────────────────────────────────────────────────
  function showPopover(link, note) {
    hidePopover();

    var parts = createPopover(note);
    positionPopover(parts.el, parts.arrow, link);

    requestAnimationFrame(function () {
      parts.el.style.opacity = '1';
      parts.el.style.transform = 'translateY(0)';
    });

    activePopover = parts.el;
    activeLink = link;

    if (!isTouch) {
      parts.el.addEventListener('mouseenter', function () {
        clearTimeout(hoverOutTimer);
      });
      parts.el.addEventListener('mouseleave', function () {
        scheduleHide();
      });
    }
  }

  function hidePopover() {
    if (activePopover) {
      var el = activePopover;
      el.style.opacity = '0';
      el.style.transform = 'translateY(4px)';
      setTimeout(function () {
        if (el.parentNode) el.parentNode.removeChild(el);
      }, 150);
      activePopover = null;
      activeLink = null;
    }
  }

  function scheduleHide() {
    clearTimeout(hoverOutTimer);
    hoverOutTimer = setTimeout(hidePopover, HOVER_OUT_DELAY);
  }

  // ── Bind events ────────────────────────────────────────────────────
  function bindLink(link) {
    var slug = slugFromHref(link.getAttribute('href'));
    if (!slug) return;

    link.setAttribute('data-garden-link', slug);

    if (!isTouch) {
      // Desktop: hover
      link.addEventListener('mouseenter', function () {
        clearTimeout(hoverOutTimer);
        clearTimeout(hoverInTimer);
        hoverInTimer = setTimeout(function () {
          loadData(function (data) {
            var note = data[slug];
            if (note) showPopover(link, note);
          });
        }, HOVER_IN_DELAY);
      });

      link.addEventListener('mouseleave', function () {
        clearTimeout(hoverInTimer);
        scheduleHide();
      });
    } else {
      // Mobile: tap — use capture phase to beat theme's click interceptor
      link.addEventListener('click', function (e) {
        e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();

        if (activeLink === link) {
          hidePopover();
          return;
        }

        loadData(function (data) {
          var note = data[slug];
          if (note) showPopover(link, note);
        });
      }, true); // capture phase
    }
  }

  // ── Global dismiss ─────────────────────────────────────────────────
  function initGlobalDismiss() {
    document.addEventListener('keydown', function (e) {
      if (e.key === 'Escape' || e.keyCode === 27) hidePopover();
    });

    document.addEventListener('click', function (e) {
      if (!activePopover) return;
      if (activePopover.contains(e.target)) return;
      if (activeLink && activeLink.contains(e.target)) return;
      hidePopover();
    });

    var scrollTimer;
    window.addEventListener('scroll', function () {
      if (!activePopover) return;
      clearTimeout(scrollTimer);
      scrollTimer = setTimeout(hidePopover, 100);
    }, { passive: true });
  }

  // ── Init ───────────────────────────────────────────────────────────
  function init() {
    detectTouch();

    var links = document.querySelectorAll('a[href*="/garden/"]');
    var isGardenIndex = window.location.pathname === '/garden/' || window.location.pathname === '/garden';

    links.forEach(function (link) {
      var href = link.getAttribute('href');
      if (!href.match(/\/garden\/[^/]+\/?$/)) return;
      if (isGardenIndex) return;
      if (link.closest('.garden-popover')) return;

      bindLink(link);
    });

    initGlobalDismiss();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
