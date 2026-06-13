---
name: dense-no-scroll-layout
description: Designing mobile screens that fit one viewport with minimal vertical scrolling — viewport budgeting per device, above-the-fold prioritization, swapping tall stacks for grids/segmented views/disclosure/detented sheets, compact metric components, and when scrolling IS the right call. Use when a screen scrolls more than it should, or when condensing a feature-heavy phone screen; pairs with layout-and-composition, grid-and-spacing, ios26-hig-patterns.
tags: [layout, density, mobile, viewport, information-architecture, no-scroll]
---
# Dense, no-scroll mobile layout

`layout-and-composition` and `grid-and-spacing` cover the general system. This skill is the specific discipline of **getting a screen to do its job within one viewport** so the user isn't endlessly scrolling a tall stack of full-width cards. The goal is not "ban scrolling" — it's "scroll only when there's genuinely more content than screen, never because the layout wastes space."

Core principle: **a phone screen is a fixed budget. Spend it on what the user came for; demote everything else off-screen, behind a tap, or into a denser form.** A tall single-column stack of one-thing-per-card is the default failure mode — it's easy to build and wastes 60% of the budget on padding and headers.

---

## 1. Budget the viewport (know your numbers)

Logical points of *content* height after chrome, on common iPhones (portrait):
- Small (SE-class): ~667pt total, ~480–520pt usable between status/nav and the floating tab bar.
- Standard (15/16/17): ~852pt, ~650–690pt usable.
- Max/Pro Max: ~932pt, ~720–760pt usable.

Design the **primary job to fit the smallest target's usable budget** (~500pt). If the core task (see today's numbers / log a meal / check progress) needs scrolling on an SE, the layout is too loose. Everything below the fold is "more," not "the point."

## 2. The condensing playbook (in order of preference)

1. **Merge cards.** One full-width card per metric is the worst offender. Combine related metrics into a single card with internal columns/rows. Five metric cards (≈110pt each ≈ 550pt) → one 4-up stat grid (≈140pt).
2. **Go horizontal.** A 2×2 or 1×N grid (`LazyVGrid`/`Grid`) or a horizontally-scrolling rail puts 4 items in the height of 1. Use for stats, quick-actions, day pickers.
3. **Segmented swap instead of stack.** If a screen shows "macros AND nutrients AND trends," don't stack all three — put a segmented `Picker` at top and swap the body. Same pixels, one section at a time, zero scroll.
4. **Disclosure / progressive reveal.** `DisclosureGroup`, "Show more", or a `.medium` detent sheet for the long tail. Default-collapse anything that's reference, not action.
5. **Inline dense rows.** A diary/list of items should be compact rows (title + value on one line, ~44pt), not cards-with-padding. Reserve cards for the 1–2 hero elements.
6. **Promote one hero, demote the rest.** Pick the single most important element (the calorie ring, the day total) and give it real space; make everything else compact.
7. **Kill redundant chrome.** Per-card titles, repeated section headers, big hero copy that restates the screen title — each eats 30–60pt. One header per region, not per card.

## 3. Components that buy density

- **Stat grid:** 2×2 or 4-up `Grid` of (value, label) pairs — 4 numbers in ~one card's height.
- **Combined progress card:** one ring or bar set (calories + the 3 macros) instead of four separate bars stacked.
- **Segmented section switcher:** `Picker(.segmented)` driving the body — the highest-leverage no-scroll tool on feature-heavy screens.
- **Compact list rows:** leading icon · title · trailing value, single line, dividers not cards.
- **Horizontal rail:** `ScrollView(.horizontal)` for day strips, quick-add chips, recent items.
- **Detented sheet** for entry/detail (see ios26-hig-patterns §3) — keeps the main screen short.

## 4. When scrolling IS correct (don't over-compress)

- A genuinely long, unbounded list (full food diary, transaction history, search results) — that's content, not layout waste. Make rows dense; scrolling is expected.
- Long-form reading (an article, terms). Don't cram.
- When compressing would push elements below 44pt targets, clip text the user needs, or stack things so tightly they read as one blob. **Density has a floor**: 8pt minimum gaps, 44pt targets, AA contrast, comfortable line length. Compress whitespace and redundant chrome first; never compress legibility or tap safety.

The test: *if a new user opened this screen, is the thing they came for visible without scrolling?* If yes and the rest is honestly "more," you're done. If the core task is below the fold, condense.

## 5. Per-screen procedure (apply to each screen)

1. State the screen's **one job** in a sentence. That element is the hero — it gets prime, above-fold space.
2. List every other element; tag each: *needed-now* (keep, compact) / *reference* (disclose or move) / *secondary action* (toolbar or sheet) / *redundant* (delete).
3. Replace stacked metric cards with a stat grid or combined card.
4. If ≥2 distinct content modes coexist, add a segmented switcher and swap.
5. Move entry/detail into a detent sheet.
6. Re-measure against the SE budget (~500pt). Iterate until the job fits.
7. Verify the floor: 44pt targets, 8pt min gaps, AA contrast, Dynamic Type still reflows.

## 6. Review checklist

- [ ] Screen's one job is visible without scrolling on a small iPhone.
- [ ] No run of ≥3 single-metric full-width cards (merged into a grid/combined card).
- [ ] Coexisting modes use a segmented swap, not a long stack.
- [ ] Reference/long-tail content is disclosed or in a sheet, not inline.
- [ ] List items are compact rows, not padded cards.
- [ ] One header per region; no per-card title restating the screen.
- [ ] Density floor intact: ≥44pt targets, ≥8pt gaps, AA contrast, Dynamic Type reflows.
- [ ] Any remaining scroll is genuine content overflow, not wasted space.
