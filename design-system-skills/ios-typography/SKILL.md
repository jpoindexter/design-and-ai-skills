---
name: ios-typography
description: iOS typography applied — the SF family system (SF Pro / Pro Rounded / Mono / New York), Dynamic Type built-in text styles + their point sizes, weights to prefer/avoid, type pairing and label-vs-value hierarchy for a minimal health/nutrition app, tabular/monospaced digits for data, and the concrete SwiftUI font APIs. Use when setting any type on a native iOS screen or building a type scale.
tags: [ios, typography, dynamic-type, sf-pro, swiftui, fonts, hig]
---
# iOS typography — Dynamic Type, SF, and data-grade numerics

Source: Apple HIG **Typography** + SwiftUI **Font** docs, cross-checked across two research passes (June 2026). Apple says: **use the built-in text styles, prefer SF, avoid thin weights, support Dynamic Type.**

## 1. The SF family system
Four system typefaces — SwiftUI selects optical sizes automatically:
- **SF Pro** — default UI sans (`.fontDesign(.default)`). Auto-switches Text (small) vs Display (large) optical sizes.
- **SF Pro Rounded** — friendlier; great for large numerics / health-app tone (`.fontDesign(.rounded)`).
- **SF Mono** — fixed-width, code/data (`.fontDesign(.monospaced)`).
- **New York** — system serif, editorial/reading (`.fontDesign(.serif)`).

Weights run Ultralight→Black. **Don't embed system fonts** — use the `Font.Design` constants. Default iOS text size is **17 pt**; minimum **11 pt**.

## 2. Dynamic Type built-in text styles (default "Large" size)
**Use these, not hard-coded sizes** — they scale with the user's setting, hit larger accessibility sizes, and switch the SF optical variant automatically.

| Style | Size (pt) | Weight | SwiftUI |
|---|---|---|---|
| Large Title | 34 | Regular | `.largeTitle` |
| Title 1 | 28 | Regular | `.title` |
| Title 2 | 22 | Regular | `.title2` |
| Title 3 | 20 | Regular | `.title3` |
| **Headline** | **17** | **Semibold** | `.headline` |
| Body | 17 | Regular | `.body` |
| Callout | 16 | Regular | `.callout` |
| Subheadline | 15 | Regular | `.subheadline` |
| Footnote | 13 | Regular | `.footnote` |
| Caption 1 | 12 | Regular | `.caption` |
| Caption 2 | 11 | Regular | `.caption2` |

> **Verify-at-source flag:** a live-HIG read in this research returned an anomalous spec table (Large Title 31 / Body 14) on the iOS Typography page, conflicting with the canonical values above and with the page's own "default body = 17pt." The **34/17** ramp above is the long-established iOS scale and is what to build to; confirm against **Apple Design Resources** (Sketch/Figma/Adobe templates) or on-device before locking a production ramp. Tracking/leading are auto-adjusted by the system per point size — don't set them manually.

## 3. Weights — prefer / avoid
- **Prefer:** Regular, Medium, Semibold, Bold.
- **Avoid:** Ultralight / Thin / Light on body or UI text — fragile, low-contrast, reads "designery but cheap." Reserve only for very large display numerals, if at all.

## 4. Pairing & hierarchy for a minimal health/nutrition app
- **One family; build hierarchy from size + weight + color + spacing**, not from many fonts. Use the built-in styles: Large Title = the screen's single title; Title 2 = section heads; Headline = eyebrow/label; Body = content; Subheadline/Footnote = secondary; Caption = metadata. **A tight scale (≈6–8 steps) is the biggest "looks designed" signal** — don't invent intermediate sizes.
- **Serif vs SF:** keep all chrome + data in **SF**; reach for **New York** only on an editorial reading surface (an insight/article screen). Serif in dense data UI usually hurts.
- **Rounded for big numbers:** `.fontDesign(.rounded)` on large calorie/macro counts gives the friendly modern health-app feel (FoodNoms/Cal-AI) without breaking HIG.
- **Label-vs-value pattern (reads premium):** a small Semibold/uppercase **caption label** (e.g. "PROTEIN", 12–13pt, secondary color) above a **large value** (rounded, 28–34pt, primary color). The value dominates by size + color; the label recedes — **don't** make the label heavier to compete.

## 5. Data-grade numerics (critical)
**Apply `.monospacedDigit()` to every number that updates or stacks in a column** — calorie counts, macro grams, weights. It fixes digit width so values don't "jitter" or misalign as digits change, while leaving text proportional. Omitting it is a top "amateur" tell.

## 6. SwiftUI font APIs
```swift
Text("Calories").font(.headline)                 // built-in, scales — PREFER
Text("1,840")
    .font(.system(.largeTitle, design: .rounded)) // style + family, still scales
    .fontWeight(.bold)
    .monospacedDigit()                            // fixed-width digits for data

.fontWeight(.semibold)        // Regular / Medium / Semibold / Bold
.fontDesign(.rounded)         // .rounded / .serif / .monospaced / .default
.font(.system(size: 17))      // fixed size — bypasses Dynamic Type, use sparingly
.font(.custom("YourFont", size: 17, relativeTo: .body))  // custom font that STILL scales
```
Custom fonts **must** use `relativeTo:` or they ignore the user's text-size setting. `.monospacedDigit()`, `.smallCaps()`, `.leading(.tight/.loose)` are all Dynamic-Type-safe.

## 7. Mistakes that read as cheap
Oversized/multiple competing Large Titles · thin weights on small text · too many bespoke sizes · non-tabular numbers in data columns · hard-coded `.system(size:)` that never scales (a11y failure) · using **weight as the only hierarchy tool** (bolding everything).

## 8. Greg application
- Replace ad-hoc `.font(.system(size: 38, design: .serif))` titles with built-in styles; reserve one Large Title per screen.
- Calorie/macro readouts: `.system(.largeTitle/.title, design: .rounded).monospacedDigit()`; labels in `.caption`/`.footnote` secondary color.
- Drop the serif display face from data UI (keep SF/SF Rounded); New York only if an insight/reading screen ships.
- Audit at the largest accessibility text size — primary numbers stay near the top, layouts stack rather than truncate.

Pairs with: `ios-layout-and-grid` (baseline/leading rhythm), `ios-color-and-materials` (label vs value color), `ios-sf-symbols-and-icons` (weight matching).
