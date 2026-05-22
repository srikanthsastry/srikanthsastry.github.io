---
title: "In Software Execution Is Decision Making"
maturity: evergreen
tags: [software-engineering, governance, brooks, essential-complexity, decision-authority]
created: 2026-04-25
related_notes:
  - data-pipeline-is-achilles-heel
  - essential-complexity-makes-software-ungovernable
  - metrics-measure-maintenance-not-creation
  - three-assumptions-framework
excerpt_text: >
  The decision/execution boundary that directive governance depends on does not exist in software.
---
**The decision/execution boundary that directive governance depends on does not exist in software.** In manufacturing, the design decision was already made and execution follows a spec. In software, everything you build is new. If it were not new, you would call the API that already does it. Every act of writing code is a design decision: choosing an abstraction, designing an interface, decomposing a system. No spec can fully predetermine these choices because [essential complexity](/garden/essential-complexity-makes-software-ungovernable/) (Brooks) cannot be fully specified.

Software decisions also compound. Every abstraction choice constrains every future choice built on top of it. A software decision lives on in the codebase and shapes all future work. The center cannot centralize what is embedded in the act of writing code.
