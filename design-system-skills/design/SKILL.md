---
name: design
description: "Use when the user invokes /design, or asks to design/build/audit/polish a web or cross-platform UI or create a design case study — screen, component, layout, table, chart, form, color system, portfolio narrative — and it's unclear which design reference skills apply. Dispatcher that routes to the right companion skills, delegates case studies to /case-study, and routes native iOS work to /ios."
---

# Design — Cross-Platform UI Skill Dispatcher

## Overview

The cross-cutting design family is 16+ reference skills. Loading them all drowns the context; loading none means eyeballing it. Transcript evidence says they work in predictable clusters — this router loads the cluster for the task.

**Resolve the target first**: the screen/component/task in the argument, else the UI work active in the conversation. State it in one line, load the routed skills via the Skill tool, and apply them while working — router, not recital. **Native iOS/SwiftUI → use /ios, not this.**

## Routing Table

| Task | Skills (in priority order) |
|---|---|
| New screen / component build (default row) | components-and-states, layout-and-composition, make-interfaces-feel-better |
| Layout redesign, reflow, spacing pass | layout-and-composition, grid-and-spacing, color-and-elevation |
| Table, chart, dashboard, metrics | data-visualization, components-and-states, accessibility-and-inclusive-design |
| Dense single-viewport UI ("fit on one screen", admin tool, inspector) | dense-no-scroll-layout, layout-and-composition, grid-and-spacing |
| Tufte-grade information display (data density, small multiples) | tufte, data-visualization |
| Design audit / QA before ship | accessibility-and-inclusive-design, components-and-states, color-and-elevation (+ data-visualization if charts/tables present) |
| Design case study / portfolio narrative | case-study dispatcher; it routes evidence, story, decisions, writing, and AI-agent supervision |
| Polish / "make it feel better" | make-interfaces-feel-better, interaction-and-motion, app-motion-and-animation |
| Motion / animation decisions | app-motion-and-animation, interaction-and-motion |
| Design system / tokens | design-tokens, grid-and-spacing, color-and-elevation |
| Color, contrast, dark mode | color-and-elevation, accessibility-and-inclusive-design |
| Copy: forms, labels, errors, empty states | ux-writing-and-content, components-and-states |
| Icons, avatars, imagery | iconography-and-imagery, design-tokens |
| Persuasion surfaces: pricing, CTAs, consent, retention | ethical-design-and-dark-patterns, ux-writing-and-content |
| "Why does this UX feel wrong" / behavioral check | laws-of-ux-and-psychology, usability-heuristics |
| Greenfield page or full redesign with taste stakes | hallmark first (it owns anti-slop direction), then this table for the parts |
| UX flows (auth, onboarding, checkout, ...) | userflow dispatcher (routes flow-*), then this table for the screens |

Ambiguous target → the default row. Marketing/landing pages → hallmark owns the visual identity; pull structural rows from here only as needed.

## Rules

- **Load at most 4 per pass.** Task matches several rows → primary row, plus the single most load-bearing skill from the secondary row.
- **Case studies route through `/case-study`.** For AI agents, that dispatcher must include `ai-agent-case-study`; do not reduce the work to a linear screen flow.
- **Audits always include accessibility-and-inclusive-design**, whatever the row says.
- **Co-fire, don't sequence**: evidence shows these skills are applied together (component anatomy while laying out, color while spacing) — load the cluster up front, not one at a time as gaps appear.
- **The dec-* canon is principles, this family is specs.** For named-principle reasoning (Nielsen, Norman, cognitive load) route via /dec; come here for concrete values (tokens, ramps, grids, state matrices).
- Name which skills you loaded, per the always-on design-skill discipline in CLAUDE.md.
