---
name: ios-liquid-glass-swiftui
description: iOS 26 Liquid Glass design language + the SwiftUI APIs that implement it, sourced from Apple's WWDC25 sessions 219/323 and developer.apple.com. Covers the functional-layer-over-content mental model, regular vs clear variants, glass-on-glass/over-tint don'ts, the floating tab bar, scroll edge effects, concentric corners, accessibility behavior, and a verified-vs-community API table. Use when building or reviewing any iOS 26 native screen's chrome, materials, or glass effects.
tags: [ios, ios26, liquid-glass, swiftui, materials, apple, hig]
---
# iOS 26 Liquid Glass — design rules + the SwiftUI APIs that ship it

Liquid Glass is the unified material introduced across iOS/iPadOS/macOS Tahoe/watchOS/tvOS 26 (WWDC June 2025). Sources below are anchored to Apple primary material — WWDC25 **session 219 "Meet Liquid Glass"** and **session 323 "Build a SwiftUI app with the new design"** — and confirmed `developer.apple.com/documentation` symbol pages. **API symbols are marked ✅ (shown in an Apple source) or ⚠️ (community-reported only — verify in the Xcode 26 SDK before relying on it).** Do not treat ⚠️ items as canonical.

## 1. The one mental model that prevents 90% of mistakes
Glass is the **functional/navigation layer that floats above the content layer.** Content scrolls *underneath* it.

- Apple, verbatim: *"Liquid Glass is best reserved for the navigation layer that floats above the content of your app."* (219)
- *"making [a tableview] Liquid Glass would make it compete with other elements and muddy the hierarchy. So keep it in the content layer instead."* (219)
- It is a light-bending meta-material, **not a blur** — its signature cue is *lensing* (it bends/concentrates light so content shows through while staying separated). It **materializes** in/out (modulating lensing), it doesn't fade. (219)
- It is **continuously adaptive**: each layer adapts to what's behind it. Small chrome (nav/tab bars) flips light↔dark with the background; large elements (sidebars, menus) adapt tint but **do not flip** (flipping would distract). (219)

## 2. Hard don'ts (all Apple-stated, 219/323)
- **No glass on glass.** *"Stacking Liquid Glass elements on top of each other can quickly make the interface feel cluttered… use fills, transparency, and vibrancy for the top elements."* Also enforced technically: *"Glass cannot sample other glass."*
- **Don't overuse it.** *"You may be tempted to use Liquid Glass everywhere but it is best reserved for the navigation layer."*
- **Don't put color/tint on everything.** *"When every element is tinted, nothing stands out… imbue color into your app… in the content layer instead."* Tint only to convey meaning (one call-to-action / next step).
- **Don't let chrome intersect content at rest.** *"In steady states… avoid intersections between content and Liquid Glass. Instead, reposition or scale the content to maintain separation."*
- **Never mix the two variants** (regular + clear) in one element.
- **Don't reintroduce redundant chrome** once on glass: remove extra sheet backgrounds, darkening behind toolbar items, custom `.presentationBackground`.

## 3. Regular vs Clear
| | **Regular** — use ~always | **Clear** — specialized |
|---|---|---|
| Adaptive behaviors | Full | **None** (permanently more transparent) |
| Legibility | Guaranteed in any context | Needs a **dimming layer** beneath it |
| Where | Any size, over any content | Media-rich content only |

Clear requires **all three** to be true (219): the element is over media-rich content, the content layer tolerates a dimming layer, and the content on top is bold/bright. SwiftUI: `Glass.regular` ✅; `Glass.clear` ⚠️ (community).

## 4. Accessibility — automatic, but verify the safety-critical surfaces
When you use the standard material, glass responds to system settings automatically (219):
- **Reduce Transparency** → glass becomes frostier, obscures more behind it.
- **Increase Contrast** → elements go predominantly black/white with a contrasting border.
- **Reduce Motion** → reduces effect intensity, disables elastic properties.

For Greg specifically: keep **safety-critical text in the solid content layer** (allergy hard-stops, macro/calorie numbers) — never floating on *clear* glass. Test every glass screen with all three settings ON. Branch in code via the existing `\.accessibilityReduceTransparency` / `\.accessibilityReduceMotion` environment keys.

## 5. The floating tab bar + content flow (323)
- Tab bar + toolbars float as glass chrome; content scrolls under, with the **scroll edge effect** handling the transition (no hard bar background).
- **Minimize on scroll** ✅: `.tabBarMinimizeBehavior(.onScrollDown)` — re-expands on scroll up, keeps content the focus.
- **Persistent accessory** above the bar ✅: `.tabViewBottomAccessory { … }`, lay out via `@Environment(\.tabViewBottomAccessoryPlacement)`.
- **Dedicated search tab** ✅: `Tab(role: .search) { … }`.
- ⚠️ Full enum case lists for `tabBarMinimizeBehavior` (`.automatic`/`.never`) and placement (`.inline`/`.expanded`) are community-reported; only `.onScrollDown` + `placement == .inline` are confirmed.

## 6. Verified SwiftUI API reference (iOS 26.0+, Xcode 26+)
**Standard controls auto-adopt glass when built with Xcode 26 — reach for `.glassEffect()` only to highlight what's unique to your app.** (323)

```swift
// Apply glass to a CUSTOM view
.glassEffect()                        // ✅ defaults to Glass.regular, capsule-ish
.glassEffect(in: .rect(cornerRadius: 16))   // ✅ custom shape
.glassEffect(.regular.tint(.green))         // ✅ tint ONLY to convey meaning
.glassEffect(.regular.interactive())        // ✅ scale/bounce/shimmer on touch

// Group + morph (share sampling region, batch render)
@Namespace var ns
GlassEffectContainer {                       // ✅ symbol page confirmed
    BadgeLabel().glassEffect().glassEffectID(badge.id, in: ns)  // ✅ glassEffectID(_:in:)
    BadgeToggle().buttonStyle(.glass).glassEffectID("toggle", in: ns)
}

// Button styles
Button("Learn More") {}.buttonStyle(.glass)           // ✅ secondary
Button("Get Started") {}.buttonStyle(.glassProminent) // ✅ prominent

// Toolbars
.toolbar {
    ToolbarItem { ShareLink() }
    ToolbarSpacer(.fixed)                              // ✅ group separation
    ToolbarItem { FavoriteButton() }
    DefaultToolbarItem(kind: .search, placement: .bottomBar)   // ✅
    ToolbarItem { ProfileButton() }.sharedBackgroundVisibility(.hidden) // ✅ detach from shared glass
}

// Search
.searchable(text: $q)
.searchToolbarBehavior(.minimize)   // ✅ NOTE: .minimize, NOT .minimized (community ref is wrong)

// Scroll edge effect — content-under-chrome legibility
.scrollEdgeEffectStyle(.hard, for: .top)   // ✅ tune sharpness for dense UIs
.scrollEdgeEffectHidden(true, for: .top)   // ✅ hide it
// ⚠️ full ScrollEdgeEffectStyle case list beyond .hard not confirmed

// Background extension — artwork fills under chrome / into safe area
Image("hero").resizable().scaledToFill().backgroundExtensionEffect()  // ✅
```

**Concentric corners (Harmony principle — nested shapes share a curve center so corners align across devices):**
```swift
.background(.tint, in: .rect(corner: .containerConcentric))  // ✅ form shown in 323
// ⚠️ community forms — verify spelling in SDK before use:
//   ConcentricRectangle(corners: .concentric, isUniform: true)
//   .containerShape(.rect(cornerRadius: 24))
```
⚠️ **Unresolved naming:** Apple's transcript shows `corner: .containerConcentric` (singular); community shows `corners: .concentric`. Likely beta API churn — **confirm in your Xcode 26 SDK.**

**Community-only (⚠️ verify before use):** `Glass.clear`/`.identity`, `glassEffectUnion`, `glassEffectTransition`/`GlassEffectTransition`, `GlassEffectContainer(spacing:)`, `matchedTransitionSource`/`.navigationTransition(.zoom(...))`, `UIDesignRequiresCompatibility` opt-out, and all battery/performance figures.

## 7. Glass vs solid — quick decision
| Use **glass** | Use **solid / content fills** |
|---|---|
| Tab bars, toolbars, nav bars (floating chrome) | Lists, cards, media, data rows |
| Standalone floating action buttons | Anything carrying brand color or meaning-tint |
| Sheets (system applies inset glass automatically) | Safety-critical / dense legibility text |
| One element over media (Clear, 3 conditions) | The second layer when something sits on glass |

## 8. Greg application
- Let the system render chrome glass; theme only `.tint(tangerine)` + your own content surfaces. Never force the tab bar opaque (that's the "white bar" bug — reserves a dead inset, kills content-scrolls-under).
- Put the tangerine accent in the **content layer** (primary button fill, key numbers), not on the bars.
- Keep `GregCard` and data rows **solid** (standard materials/fills), not glass — they're content.
- If adopting `.tabViewBottomAccessory`, use it for a persistent "log food" affordance, not decoration.

Pairs with: `ios-color-and-materials` (material levels + semantic color), `ios-components` (bar behavior), `ios26-hig-patterns` (field manual).
