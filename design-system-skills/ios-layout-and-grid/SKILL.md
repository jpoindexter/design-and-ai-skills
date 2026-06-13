---
name: ios-layout-and-grid
description: iOS layout & spacing for iPhone — the 8pt grid convention + 4pt sub-grid, real Apple layout numbers (16/20pt system margins, safe-area insets, 44/49/50pt bar heights), the 44pt touch target, building dense low-scroll layouts with LazyVGrid/Grid + GridItem (2-up/3-up rules), SwiftUI's adaptive default spacing, and the iOS 26 floating-chrome layout model. Use when laying out any iPhone screen, choosing margins/gutters, or building a grid.
tags: [ios, layout, grid, spacing, safe-area, swiftui, density, hig]
---
# iOS layout & grid — spacing that reads "designed", on iPhone

Source: Apple HIG **Layout**, UIKit/SwiftUI API docs, and the 8pt-grid convention (June 2026). Numbers tagged **[Apple]** (stated in HIG/API) or **[convention]** (community practice that *aligns with* Apple's point system — Apple publishes no mandatory pixel grid).

## 1. The 8-point grid (+ 4pt sub-grid) — [convention]
iOS measures in **points** (1pt = 1px @1x, 2px @2x, 3px @3x). Snap spacing/sizing to **multiples of 8** so they land on whole pixels at every scale (@2x→16, @3x→24) and scale cleanly across devices. Use a **4pt sub-grid** for finer/typographic spacing and baseline alignment.
- **Standard scale to use:** 4, 8, 12, 16, 24, 32, 40, 48.
- One consistent **gutter (16pt)** + one consistent **inter-card gap (8 or 12pt)** reads designed; mixing arbitrary gaps reads amateur.

## 2. Real layout numbers
- **Screen side margins:** `systemMinimumLayoutMargins` resolve to **16pt** on compact-width iPhones, **20pt** on larger widths. [Apple behavior / widely-cited] This is why inset-grouped lists and large titles share a left edge.
- **`directionalLayoutMargins`** — Apple's leading/trailing-aware default content spacing (use this, not left/right). [Apple]
- **`readableContentGuide`** — caps text width for readability; never exceeds the layout-margin guide and **widens with Dynamic Type**. Use for long body text. [Apple]
- **Bar heights — DON'T hard-code; read `safeAreaInsets`:** nav bar **44pt** (large-title adds a second row), tab bar **~49–50pt**, toolbar **44pt** (50 on iPad). Status bar / Dynamic Island top inset is device-dependent. Apple's rule: read `safeAreaInsets.top`/`.bottom`. [Apple]
- **`viewRespectsSystemMinimumLayoutMargins`** (default true) keeps root margins ≥ the system minimums. [Apple]

## 3. Touch targets — [Apple]
- **Design to 44×44 pt** minimum tappable area for every control — the long-standing, still-current rule, reaffirmed for iOS 26.
- Apple's Accessibility page now also lists a **28×28 pt absolute minimum** (44 = the recommended default). Treat 44 as the design target; 28 is a hard floor, not a goal.
- **Inline text links** are the explicit exception (allowed smaller — body line-height is shorter).
- **Gap between controls:** Apple states no single number; convention is **≥8pt** between adjacent 44pt targets (HIG also notes ~12pt around bezeled, ~24pt around un-bezeled controls).
- Density comes from tightening **non-interactive** content (text, icons, dividers have no minimum) — never from shrinking buttons below 44pt.

## 4. Dense, low-scroll layouts with SwiftUI grids
- **`LazyVGrid`/`LazyHGrid`** — lazy, renders only visible cells; for long/scrolling collections.
- **`Grid`/`GridRow`** (iOS 16+) — eager, for small fixed 2D layouts where you want column alignment across rows.
- **`GridItem` controls columns:**
  - `.fixed(w)` — exact-width column.
  - `.flexible(min:max:)` — splits width equally; use for explicit **2-up/3-up** card grids: `Array(repeating: .flexible(), count: 2)`.
  - `.adaptive(minimum:)` — fits as many columns as possible at a min width; for variable counts (chips, photo grids).
  - `GridItem(spacing:)` = inter-column gap; the grid's `spacing:` = row gap.
- **2-up vs 3-up rule of thumb [convention]:** on a 390pt phone (after 16pt margins + 16pt gutter), 2-up cards ≈ 170pt wide (label+value, still readable); 3-up ≈ 110pt (compact icon/number tiles only). Below ~100pt wide, switch to a **horizontal scroll row** instead of cramming a grid.

## 5. SwiftUI default spacing — set it explicitly
`VStack`/`HStack` with `spacing: nil` (the default) is **adaptive** — SwiftUI picks a distance per pair of subviews by type/platform; the "8pt default" is an approximation, **not a constant**. For a strict 8pt grid, **set spacing explicitly** (`VStack(spacing: 8)`). [Apple behavior]
- **Lists/Forms:** `listRowInsets` sets per-row padding; inset-grouped horizontal insets come from the table's `layoutMargins` (the 16/20pt system margins) — which is why inset-grouped cards align with large-title text. [Apple]

## 6. iOS 26 floating-chrome layout model
Nav bar + toolbars + tab bar render as floating **Liquid Glass** elements and **content scrolls underneath them** (vs old opaque bars that shrank the content frame). [Apple]
- Design so the top/bottom of scroll content can pass under translucent chrome **without permanently occluding important info** — the system adds bottom content insets so the last item clears the floating tab bar at rest.
- The tab bar is a floating, centered pill inset from the edges; don't force it opaque (reserves a dead inset — the "white bar" bug). See `ios-liquid-glass-swiftui`.

## 7. Greg application
- Lock the spacing scale to 4/8/12/16/24/32; `GregCard` padding to a grid multiple; one 16pt screen gutter, one consistent inter-card gap.
- Use a **2-up `LazyVGrid`** for the macro tiles (protein/carbs/fat/cost) instead of stacking full-width cards — cuts vertical scroll, each tile ≈170pt.
- Read `safeAreaInsets` for any custom bottom affordance; never hard-code a bottom pad above the tab bar.
- Set `VStack(spacing:)` explicitly everywhere (don't rely on the adaptive default) so the rhythm is intentional.
- Keep every tap target ≥44pt; gain density by tightening text/dividers and going multi-column, not by shrinking controls.

Pairs with: `ios-typography` (type rhythm), `ios-liquid-glass-swiftui` (floating chrome), `dense-no-scroll-layout` (cross-platform density), `ios-components` (bar heights/insets).
