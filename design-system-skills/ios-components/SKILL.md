---
name: ios-components
description: Apple HIG component rules for native iOS 26 — bars (tab/nav/toolbar/search incl. floating + concentric corners), buttons (44pt hit region, prominence, roles, no destructive-primary), menus/pull-down/pop-up, toggles/pickers/segmented/sliders/steppers/text fields, lists & tables, sheets + detents, alerts vs action sheets vs popovers, modality, progress/gauges, with the SwiftUI mapping. Use when choosing or reviewing any iOS control or presentation.
tags: [ios, components, controls, sheets, alerts, toolbar, tab-bar, hig, swiftui]
---
# iOS components — the rules that make controls feel native (iOS 26)

Source: Apple HIG component pages (read June 2026). iOS 26 floats chrome on Liquid Glass — read `ios-liquid-glass-swiftui` for the material behavior; this is the per-component rulebook.

## Bars
**Tab bar** — top-level *navigation*, not actions. Floats on glass at the bottom; content peeks through. 2–5 destinations (more → a "More" tab; avoid). **Don't hide/disable tab items** when their content is empty — explain the empty state instead. Single-word labels; **prefer filled SF Symbols**. iOS 26: optional dedicated **search tab** at the trailing end; optional **minimize-on-scroll**. Badges (red oval) only for critical info.

**Navigation bar** = a navigation-specific toolbar at the top. **Large title by default**, collapses to inline on scroll (keep this). Use the **standard Back/Close** symbols — *don't* label them "Back"/"Close". Use inline title on dense utility screens.

**Toolbar** — horizontal control groups along top/bottom. iOS 26: *"Reduce the use of toolbar backgrounds and tinted controls"*; let the content layer inform the toolbar's color; use a scroll edge effect to separate it. **Standard components get corner radii concentric with the bar** — keep custom ones concentric too. Prefer **borderless** system symbols. **`.prominent` style for the one primary action (Done/Submit), on the trailing side.** Aim for ≤3 logical groups; titles <15 chars; never title with the app name. iOS: keep only the most important items in the bar, push the rest to a **More** menu.

**Search** — give it a primary position if important (Notes = bottom toolbar; Photos = a Search tab). Make content searchable from a single location; show scope via placeholder/scope bar/title; provide recent + predictive suggestions; let people clear history. `.searchable(text:)` + `.searchToolbarBehavior(.minimize)`.

## Buttons & actions
- **Hit region ≥ 44×44 pt** (visionOS 60). Always include a **press state** for custom buttons.
- **Use style, not size, to mark the preferred action.** One or two prominent buttons per view max.
- **Roles:** Normal, Primary (accent, responds to Return), Cancel, Destructive (system red). **Never assign the primary role to a destructive action** — people tap primary without reading.
- Verb-first title-case labels; familiar SF Symbols for familiar actions (`square.and.arrow.up` = share). iOS: show an activity indicator for non-instant actions ("Checkout" → "Checking out…").
- **Menus:** title-case, drop articles, "…" when more input needed, dim unavailable items. iOS layouts: Small (4 symbol-only), Medium (3 symbol+label), Large (default list). **Pull-down** = actions / multi-select / submenu (≥3 items feels worthwhile); **Pop-up** = mutually-exclusive options, button shows current selection.

## Selection & input
- **Toggle/switch:** *"Use the switch toggle style only in a list row."* Outside a list, use a toggle-styled **button**, not a switch. Don't rely on color alone for state.
- **Picker:** medium-long value lists; show in context (bottom/popover), *"avoid switching views to show a picker."* Date picker styles: compact / inline / wheels / automatic.
- **Segmented control:** ≤ ~5 segments on iPhone; single choice among closely-related subviews; text *or* images, not both. For separate app sections use a tab bar instead.
- **Slider:** min leading / max trailing; **don't use a slider for audio volume**. Pair with a field+stepper for exact values.
- **Stepper:** doesn't show its own value — sits next to a field that does; pair with a text field for large changes.
- **Text field:** show a placeholder hint **and** a persistent label; secure field for sensitive data; correct keyboard type; trailing **Clear** button; validate at the right moment (email on field-switch). **Never prepopulate a password field.**

## Content
- **Lists & tables:** prefer text in lists; for varied/image-heavy items use a **collection**. iOS **inset-grouped** style for settings/forms (headers/footers/space separate groups). **Disclosure indicator** = drill into a subview; **info/detail button** = reveal more about a row (not navigation).
- **Collections:** image-based content; standard row/grid layouts; use a table for text.
- **Scroll views:** iOS 26 **scroll edge effect** separates floating chrome from content — *"only use it when a scroll view is behind floating interface elements… not decorative,"* **one per view**, prefer the **automatic** style. Don't nest same-axis scroll views.
- **Charts:** see `data-visualization`; make every chart accessible (VoiceOver + Audio Graphs via Swift Charts), don't rely on color alone, add a descriptive takeaway.

## Presentation (pick the right one)
- **Sheet** — a scoped task related to the current context. **Detents:** system `.large` + `.medium`; *"consider supporting the medium detent to allow progressive disclosure"* on iPhone. Include a **grabber** on resizable sheets. Cancel = leading, Done = trailing; support swipe-to-dismiss (confirm if unsaved changes). **One sheet at a time.** Complex/long flow → full-screen modal instead.
- **Popover** — transient, arrow points at the triggering control; **avoid in compact (iPhone) width — use a sheet**; never use a popover for a warning (use an alert).
- **Alert** — critical, time-sensitive, ideally actionable; ≤3 buttons. **Use sparingly**; *"avoid using an alert merely to provide information"*; don't alert on common undoable destructive actions; never alert at launch. Default/most-likely button trailing/top, Cancel leading/bottom; destructive style only when the user *didn't* deliberately choose it; always include Cancel with a destructive action; never make Cancel default.
- **Action sheet** (`confirmationDialog`) — choices tied to an **intentional** action. Cancel at the bottom; destructive choices prominent at the top. Use this — not an alert — for choices on a user-initiated action.
- **Modality** — present modally only with a clear benefit; keep modal tasks short; always give an obvious dismissal; confirm before closing if content would be lost; **one modal at a time** (an alert may appear above another modal).

## Status
- **Progress:** prefer **determinate** when duration is known; report accurately, keep it moving; *"don't switch from the circular style to the bar style."* iOS pull-to-refresh control optional.
- **Gauge:** single value in a range (standard = indicator, capacity = fill); succinct value + endpoint labels for VoiceOver.

## Greg application
- Bottom **tab bar** for the 3–5 top sections (filled symbols); **toolbar** `+` for actions, not navigation.
- "Log food" flows open as a **sheet** at `.medium` (progressive disclosure), draggable to `.large`.
- Allergy/irreversible confirmations: **action sheet** with destructive-styled choice on intentional actions; reserve **alerts** for true safety stops.
- Profile/targets editing: **inset-grouped list**; switches only in rows; numeric entry with a stepper+field and the right keyboard type.
- One prominent (tangerine) primary button per screen; everything else secondary/plain.

Pairs with: `ios-liquid-glass-swiftui`, `ios-flows-and-patterns` (modality/feedback), `ios26-hig-patterns`.
