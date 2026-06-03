---
title: "You Don't Have a Relationship with Your LLM. You Have Five."
published: 2026-06-03
tags:
  - 'AI'
  - 'cognitive psychology'
  - 'human-AI interaction'
abbrlink: 'you-dont-have-a-relationship-with-your-llm'
lang: ''
excerpt: >
  The fatigue from a day of AI pair-programming isn't information overload or decision fatigue. You are unconsciously switching between five relational modes with the AI (director, trainer, partner, student, consumer) dozens of times per session. Each switch costs executive attention, emotional labor compounds the cost, and the AI's lack of emotional reciprocity prevents recovery. Three mechanisms, one conjecture, falsifiable predictions.
image: /assets/images/relational-switching-costs-cover.jpg
categories:
  - Professional
---

This is happening to me often enough to where I need to understand it. It's not just me. I have heard this from my colleagues and friends as well. It is this strange feeling of fatigue when I have spent a large portion of the day chatting with the AI agent to generate code and get work done. I have seen it referred to as "AI fatigue", but that doesn't quite capture the feeling and does even less to explain it.

The standard explanations for it include information overload, decision fatigue (from evaluating AI output), cost of increased productivity, etc. They all capture parts of it and don't add up to the entirety of the experience. Sure, there is some cost to evaluating AI output, but I do that with code reviews from human-authored code too, and it does not drain me out like this. Yeah, I am more productive, but that's AI doing the heavy lifting; so why do I feel tired?

In search of an explanation, I started digging around academic research and published reports to see if this has been figured out. What I found was a bunch of adjacent literature that seems to connect up to something, but no kill shot. What follows is my conjecture, and possible experiments that could disprove it.

## The five relationships

When you are working with an AI agent, you are subconsciously developing a relationship with the AI (albeit an unrequited one) despite consciously recognizing that the AI is "just a tool". You get occasional glimpses of this relationship when you find yourself saying "please" or swearing at the AI in text; you would never do this with your compiler, and yet it is normal with an AI agent.

Your relationship with the AI can take five forms, [oscillating between them unconsciously](/garden/relational-mode-oscillation/) ([Gülay et al. 2025](https://doi.org/10.48550/arXiv.2509.15836)):

1. *Director*: You are giving instructions to the AI agent to perform tasks (such as "refactor this module")
2. *Trainer*: You are teaching the AI agent how to perform the tasks (e.g., "Use the `git log` command to fetch the historical commits").
3. *Partner*: Here you are collaboratively working with the AI to accomplish the task (e.g., you come up with a hypothesis for a root cause and ask the AI agent to come up with counter examples to falsify it, and then look for evidence)
4. *Student*: You are asking the AI to teach you things. (e.g., you ask the agent to summarize a design document, or ask it to explain how, say, Kafka works)
5. *Consumer*: You are asking and following instructions from the AI. (e.g., you have a root cause of a bug and you ask the AI how you should fix it)

Others have found different ways to categorize this relationship. If you think of ways in which you use AI to obtain knowledge and understanding ([Yang & Ma 2025](https://doi.org/10.48550/arXiv.2508.03673)), you get five different categories: Instrumental Reliance, Contingent Delegation, Co-agency Collaboration, Authority Displacement, Epistemic Abstention. The field is nascent; stable categories don't exist yet.

Regardless, we do have different forms of relationships with AI, and we are in all of them *simultaneously*. Within a single session, you switch from one form of relationship to another, and this happens seamlessly and without your conscious acknowledgement. You start a session commanding ("fix this bug"), shift to collaborating ("what if we tried X instead?"), find yourself teaching ("no, the constraint is Y because..."), then deferring ("actually your approach is better"), then passively reviewing output. Five modes. One conversation. You didn't decide to switch. You just did.

The fatigue you feel at the end of the day is an accumulation of these relationship oscillations.

## The switching is not free

We have evidence from the cognitive task switching literature ([Monsell 2003](https://doi.org/10.1016/S1364-6613(03)00028-7); [Rogers & Monsell 1995](https://doi.org/10.1037/0096-3445.124.2.207); [Kiesel et al. 2010](https://doi.org/10.1037/a0019842)) that switching between tasks carries measurable, residual costs. This happens because when we switch tasks, we are really reconfiguring our mental set: new expectations, response mappings, and success criteria. This cost is why multitasking is less productive than spending a focused amount of time on a single task.

The switching cost extends from tasks to relationships as well. Studies show that [social role-switching frequency is a predictor of stress](/garden/role-switching-frequency-predicts-stress/), independent of the total number of roles ([Cornwell 2013](https://doi.org/10.1177/0190272513482133)): in a sample of 7,662 adults, those who switched between social roles more frequently reported higher stress. (The effect held for women but not men, suggesting gendered differences in switching costs that the AI interaction context may or may not preserve.) It's not that having more roles is stressful; it's that switching between them more often is.

Each of the five relationship modes with AI carries different expectations for what counts as good output, how to phrase your input, what level of explanation to provide, and whether to accept or challenge the response. Each switch is a reconfiguration of mental set, which is the same mechanism Monsell documents for cognitive tasks, applied to social framing. If (and it is an *if*) the mechanisms associated with the relationship switches with AI are the same as the task and role switching in social contexts, then the fatigue from such stress simply follows naturally.

## Emotional labor tax

There is an added cost to interacting with AI. We are not simply talking to the AI; we are performing a persona. Each relationship mode requires a different one. Directing an AI requires one emotional register (authority, concision). Teaching it requires another (patience, pedagogical framing). Collaborating with it requires a third (openness, intellectual generosity). Each switch is not just a cognitive reconfiguration; it's an emotional labor transition. You're changing which emotions you're performing, not just which task you're doing.

The emotional labor literature (e.g. [Hochschild 1983](https://openlibrary.org/works/OL2627283W) and [Brotheridge & Lee 2002](https://doi.org/10.1037/1076-8998.7.1.57)) shows that performing emotions you don't feel (surface acting) produces estrangement and burnout: emotional exhaustion, depersonalization, a progressive depletion of the capacity to keep performing. The literature has extensively studied the cost of sustained surface acting toward one audience: customers, patients, students. *What it has not studied is the cost of switching emotional performances rapidly within a single interaction.*

**My conjecture is that these results transfer to our interactions with AI, and so the cost of emotional labor acts as a compounding factor on top of the cost of switching relationship modes itself.** Nobody has studied what happens when you're switching cognitive frames, social roles, AND emotional performances simultaneously, dozens of times per session. In isolation, these literatures point in the same direction, but they measure different things on different timescales: Task switching literature measures costs in milliseconds in controlled tasks; role switching literature measures daily stress; and emotional labor literature measures chronic burnout. The convergence is thematic, not mechanistic. That's what makes this a conjecture worth testing, not a conclusion.

## Instability surcharge

With a human colleague, you settle into a relationship mode relatively quickly, and the changes in the mode are occasional and they evolve. For example, it could start with "he is my tech lead", and in a few months "he is my manager". It typically happens unconsciously. With a tool, you settle into "this is a tool" and the framing never wavers. But our relationship with AI is neither.

[AI agents are categorically ambiguous](/garden/categorical-ambiguity-of-ai/). You say it is a tool; you know it is a tool; you want to use it as a tool. Yet, when you actually start using it, your relationship with it changes, and it changes continually.

Previously, under the ["Computers are Social Actors" (CASA) framework](/garden/casa-framework/) ([Nass & Moon 2000](https://doi.org/10.1111/0022-4537.00153)), the claim was that people apply social rules to computers automatically because the computer's outputs trigger social cues (albeit minimal). But this does not hold for AI agents.

One explanation: AI is a novel technology, and we are not habituated to it. Recent work shows that [CASA effects may not survive habituation](/garden/casa-habituation/) ([Heyselaar 2023](https://doi.org/10.1038/s41598-023-46527-9), *Scientific Reports*): replicating the CASA experiment with people who grew up with computers around them, the habituation to the technology seemed to have nullified the CASA effect. So perhaps our next generation will not have this issue. But I suspect that is not the story. Desktop computers and AI agents are categorically different.

AI agents' social cues are rich but also simultaneously inconsistent. AI can act like a subordinate, assert like a peer, or even explain complex concepts like a teacher, and it all happens in the same conversation. CASA's prediction holds when the computer's social cues are coherent, and here they are not. With contradictory cues, the ambiguity around the AI's relational mode never resolves. We are forever in a situationship with the AI.

## Unrequited debt

You might have a relationship with the AI, but AI does not have a relationship with you. Recall from emotional labor theory that sustained surface acting produces burnout. Social reciprocity partially offsets it between switches. This recovery mechanism is built into the interaction, which is why you are not a dried husk after day-long interactions with your colleagues (assuming you actually like working with them). But an AI agent is a different matter.

Your AI agent returns well-formed output and gives you useful feedback, but it does not provide emotional reciprocity. It does not feel 'thankful' nor does it 'look forward' to interacting with you. Human-agent interaction is genuinely social ([Banks 2026](https://doi.org/10.48550/arXiv.2604.05197), "Ghosting the Machine"): not parasocial, not pretend-social, but the real thing. That means the depletion from unrequited emotional labor is real, with no recourse for replenishment. It is completely unrequited.

This [absence of reciprocity accelerates the fatigue](/garden/broken-reciprocity-as-fatigue-accelerant/). If you were to treat the AI (say) as a subordinate all day long, then your emotional labor would leave you depleted. But that is not how you treat the AI agent. You are constantly switching modes, and each switch has an additional cost on top of your ongoing cost of this unrequited interaction. The depletion compounds with each interaction, faster with each switch, and there is no avenue for replenishment.

## Your situationship explained

Here is my hypothesis. The AI fatigue is not about doing too much or being too productive or making too many decisions. AI's interaction pattern subconsciously draws you into a relationship with it. This relationship is constantly changing and does not have a stable interaction frame. This is compounded by the emotional labor on each switch of the frame, and accelerated by the lack of emotional reciprocity from the AI. There are three factors that compound: the relationship mode switching is the driver, the emotional labor is the multiplier, and the broken reciprocity prevents attenuation of the cost.

Like all good hypotheses, this one is falsifiable. Here are some experiments to shed light on the phenomenon. Take away the AI agent, and replace it with a human, and the fatigue should become significantly attenuated. If you were to coerce the interaction with AI to be in a single relationship mode, the effect should be a lot smaller. Reduce the number of switches, and the fatigue should be less.

If I am right, then the issue isn't that the AI isn't more human-like. The culprit is that AI's social cues are inconsistent and without emotional reciprocity. Making AI more human-like without making it relationally consistent should only make the problem worse.

The implication is not that we should make AI less capable or use it less. It is the opposite. Not that we should make AI more human-like; we should make AI more capable of holding a relationship with a human in a fixed or natural register. This problem looks solvable.
