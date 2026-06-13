---
name: ios26-hig-patterns
description: iPhone-specific Apple Human Interface Guidelines for iOS 26 (Liquid Glass) — the floating tab bar and how content scrolls under it, navigation/sheets/presentation detents, SF Symbols + Dynamic Type + safe areas, control styles, 44pt touch targets, and the concrete SwiftUI modifiers that implement each. Use when building or reviewing any native iPhone screen; pairs with platform-conventions (cross-platform) and components-and-states.
tags: [ios, iphone, hig, apple, swiftui, liquid-glass, ios26]
---
# iOS 26 HIG — iPhone patterns that actually ship

`platform-conventions` covers cross-platform norms and `design-system-frameworks` covers HIG's *philosophy* (deference, clarity, depth). This skill is the iPhone-on-iOS-26 field manual: the specific behaviors and SwiftUI modifiers that make a screen feel native instead of like a ported web app. iOS 26's design language is **Liquid Glass** — translucent, layered surfaces that refract the content behind them; the system chrome (tab bar, toolbars, sheets) floats *over* content rather than boxing it in.

The single most common iOS-26 mistake: forcing system chrome opaque to "match the brand." That fights the platform, breaks content-scrolls-under behavior, and reserves dead insets (the classic "white bar above the tab bar"). Default to letting the system render its chrome; theme only `tint` and your own surfaces.

---

## 1. The floating tab bar (the #1 iOS-26 gotcha)

On iOS 26 a `TabView` renders as a **floating, translucent pill** inset from the screen edges. Content is expected to scroll *underneath* it; the system adds a bottom content inset so the last item can clear the bar at rest.

- **Do** let it be translucent. A `ScrollView`/`List` inside a tab automatically gets the correct bottom inset and content refracts through the glass as it scrolls.
- **Don't** force it opaque:
  ```swift
  // ANTI-PATTERN — reserves a large opaque inset, content can't scroll under, dead "white bar".
  UITabBar.appearance().standardAppearance = opaqueWhiteAppearance
  .toolbarBackground(.visible, for: .tabBar)
  ```
  Removing both restores native behavior. Only set an opaque background if a specific screen genuinely needs it, and then expect the inset.
- Theme the selection/icon color with `.tint(brandColor)` on the `TabView`, not by overriding the bar's material.
- Tab items: 2–5 destinations, each a `Label(text, systemImage:)`. More than 5 collapses into "More" — avoid.
- `.tabBarMinimizeBehavior(.onScrollDown)` (iOS 26) lets the bar shrink as the user scrolls a long page — use it on content-heavy tabs to reclaim space instead of fighting the inset.

## 2. Navigation & titles

- `NavigationStack` (not the deprecated `NavigationView`). Large title by default; it collapses to inline on scroll — this is good, keep it.
- Use inline titles (`.navigationBarTitleDisplayMode(.inline)`) on dense utility screens where a large title wastes the first 60pt.
- Toolbar items go in `.toolbar { ToolbarItem(placement: .topBarTrailing) { … } }`. On iOS 26 toolbars are also Liquid Glass and float — don't background them opaque either.
- Back navigation is the system swipe + chevron; never build a custom back button that breaks the edge-swipe.

## 3. Sheets & presentation detents

Modeless, partial sheets are the iOS-native way to add detail without a full push.
- `.sheet(isPresented:)` + `.presentationDetents([.medium, .large])` — start at `.medium` for a quick action (log food, edit a value), let the user drag to `.large`.
- `.presentationDragIndicator(.visible)` for discoverability.
- `.presentationBackgroundInteraction(.enabled(upThrough: .medium))` when the user should still see/scroll the screen behind.
- Use a detented sheet instead of a new pushed screen for: quick entry forms, filters, a single item's detail, confirmations with options. Reserve full pushes for genuinely new contexts.

## 4. SF Symbols

- Use SF Symbols for all standard iconography — they auto-scale with Dynamic Type, support weights, and get hierarchical/multicolor rendering for free.
- Match symbol weight to adjacent text weight; use `.symbolRenderingMode(.hierarchical)` for depth, `.palette` for two-tone brand accents.
- `.symbolEffect(.bounce)` / `.pulse` for state changes (logged ✓, syncing) — subtle, not decorative.
- Don't ship custom raster icons where an SF Symbol exists; you lose scaling + accessibility.

## 5. Dynamic Type, color, contrast

- Use semantic text styles (`.font(.body)`, `.headline`, `.caption`) so text scales with the user's setting. If you hardcode sizes, gate the largest accessibility sizes and test at `AX5`.
- `.dynamicTypeSize(...DynamicTypeSize.accessibility3)` to cap on a layout that genuinely can't grow further — but prefer reflowing.
- Colors: prefer semantic/system colors or a token set that has light + dark variants. Respect `@Environment(\.colorScheme)`. Hit WCAG AA (4.5:1 text). The HIG's "increase contrast" and "reduce transparency" accessibility settings should still leave Liquid Glass legible — test with Reduce Transparency on.

## 6. Touch targets & layout safety

- **44×44 pt minimum** hit target for every interactive element (Fitts/HIG). A 20pt glyph still needs a 44pt tappable frame — pad it.
- Respect safe areas: never put controls under the Dynamic Island, home indicator, or behind the floating tab bar. Use `.safeAreaInset(edge:)` to add a pinned footer that the system insets correctly, instead of manual bottom padding.
- `.safeAreaPadding` over raw `.padding` when the intent is "clear the system chrome."
- Honor `@Environment(\.accessibilityReduceMotion)` — drop parallax/large transitions when set.

## 7. Controls (use the native ones)

- `Button(role: .destructive)`, `.confirmationDialog` for destructive choices, `Toggle`, `Stepper`, `Picker` (menu/segmented/wheel), `Slider`. Native controls inherit Liquid Glass, Dynamic Type, VoiceOver, and haptics for free.
- Segmented `Picker(.segmented)` is the canonical way to switch a screen's view without a new push or scroll — central to dense layouts.
- `.buttonStyle(.borderedProminent)` for the single primary action; `.bordered`/`.plain` for secondary. One prominent action per screen region.
- Haptics: `.sensoryFeedback(.success, trigger:)` on confirmations, `.selection` on segmented/stepper changes.

## 8. Quick review checklist

- [ ] Tab bar / toolbars left translucent (no forced-opaque appearance); content scrolls under cleanly, no dead inset.
- [ ] `NavigationStack`, large title that collapses; inline title on dense screens.
- [ ] Quick detail/entry uses a `.medium` detent sheet, not a full push.
- [ ] All icons are SF Symbols; weights match text.
- [ ] Text uses semantic styles; tested at AX5; AA contrast; legible with Reduce Transparency.
- [ ] Every interactive ≥44pt; nothing under the island/home-indicator/tab bar.
- [ ] Native controls (segmented Picker, Stepper, Toggle); one prominent action per region; haptics on state changes.
