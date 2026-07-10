---
name: ios
description: "Use when the user invokes /ios, or when starting ANY native iOS/SwiftUI screen, component, flow, or review and it's unclear which ios-* skills apply. Dispatcher that routes to the right 2-4 companion ios-* reference skills instead of loading the whole family or designing from memory."
---

# iOS — HIG Skill Dispatcher

## Overview

The ios-* family is 15 reference skills. Loading all of them drowns the context; loading none means designing from memory — which misses the concrete specs (point values, contrast floors, current SwiftUI APIs) the skills exist to carry. This dispatcher routes a task to the 2–4 skills that carry its specs.

**Resolve the target first**: the screen/component/flow named in the argument, else the iOS work active in the conversation. State it in one line, then load the routed skills via the Skill tool and apply them while working — this is a router, not a checklist to recite.

## Routing Table

| Task | Skills (in priority order) |
|---|---|
| Any new iPhone screen (default row) | ios26-hig-patterns, ios-layout-and-grid, ios-components |
| Choosing/reviewing a control, bar, sheet, alert, menu | ios-components, ios26-hig-patterns |
| Text, type scale, Dynamic Type | ios-typography, ios-accessibility |
| Color, dark mode, materials, Liquid Glass | ios-color-and-materials, ios-liquid-glass-swiftui |
| A flow: onboarding, permissions, settings, search, IAP, ratings, empty/loading states | ios-flows-and-patterns, ios-components |
| Motion, transitions, animation | ios-motion-and-animation, ios-gestures-and-haptics |
| Gestures, haptics | ios-gestures-and-haptics |
| SF Symbols, in-app iconography | ios-sf-symbols-and-icons |
| App icon, screenshots, App Store page | ios-app-icon-and-app-store |
| Widgets, Live Activities | ios-widgets-and-live-activities |
| Charts, data display | ios-charts-and-data-visualization, ios-layout-and-grid |
| Accessibility audit of a screen | ios-accessibility, ios-color-and-materials |
| Food/macro-tracking app UI | macro-food-app-ui, ios26-hig-patterns, dense-no-scroll-layout |
| Full HIG review of an existing screen | ios26-hig-patterns, ios-components, ios-accessibility, ios-color-and-materials |

## Rules

- **Load at most 4 per pass.** A task matching several rows → primary row first, then the single most load-bearing skill from the secondary row.
- **`ios26-hig-patterns` rides along on anything visual and new** — it carries the platform baseline (floating tab bar, detents, 44pt targets, safe areas) the other skills assume.
- **Never substitute the web skills** (`hallmark`, `components-and-states` CSS patterns) for native iOS screens; cross-platform principles come from the /design family only as a supplement, never a replacement.
- **Accessibility is not optional extra routing**: any shipped-screen review includes ios-accessibility even if the row doesn't list it.
- Name which skills you loaded, per the always-on design-skill discipline in CLAUDE.md.
