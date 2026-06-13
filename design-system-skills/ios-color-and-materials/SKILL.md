---
name: ios-color-and-materials
description: iOS semantic system colors, dark mode, and material levels per Apple HIG (current iOS 26). Covers why you never hard-code system color values, the system vs grouped background sets, label/separator colors, dark mode base-vs-elevated + the 4.5:1/7:1 contrast floors, the four standard material levels + vibrancy, Liquid Glass color rules, and Display P3. Use when choosing colors, backgrounds, or materials for any native iOS screen.
tags: [ios, color, dark-mode, materials, vibrancy, hig, apple, accessibility]
---
# iOS color & materials — semantic, adaptive, never hard-coded

Source: Apple HIG **Color**, **Dark Mode**, and **Materials** pages (read June 2026; change logs confirm iOS-26 currency). Apple renders hex/RGB values as image swatches and explicitly says **not to hard-code them** — so this skill names the *semantic APIs*, not numbers.

## 1. The rule: use dynamic, semantically-named colors
*"Documented color values are for your reference… The actual color values may fluctuate from release to release."* Use the APIs so colors auto-adapt to light/dark + Increase Contrast + Liquid Glass.
- **Don't redefine a semantic color's meaning** (don't use `separator` as text, or `secondaryLabel` as a background).
- **Always supply light + dark variants for custom colors**, plus an increased-contrast option — *"Even if your app ships in a single appearance mode, provide both light and dark colors to support Liquid Glass adaptivity."*

## 2. The color APIs you actually use
**System named colors (SwiftUI):** `red orange yellow green mint teal cyan blue indigo purple pink brown` — each has default + increased-contrast variants for light/dark.

**Grays:** UIKit `systemGray`, `systemGray2…6`; SwiftUI `gray` ≈ `systemGray`.

**Background sets — two families, each primary/secondary/tertiary (express hierarchy by nesting):**
- System: `systemBackground` → `secondarySystemBackground` → `tertiarySystemBackground`
- Grouped (use with grouped lists/forms): `systemGroupedBackground` → `secondarySystemGroupedBackground` → `tertiarySystemGroupedBackground`
- Primary = overall view; Secondary = a group within it; Tertiary = a group within secondary.

**Foreground / separators:** `label` → `secondaryLabel` → `tertiaryLabel` → `quaternaryLabel`; `placeholderText`; `separator` (lets content show through) vs `opaqueSeparator`; `link`.

**Inclusive color (required):** never convey meaning/state/interactivity by color alone — pair with text, glyph shape, or position. Watch red-green / blue-orange confusions; consider cultural meaning.

## 3. Dark Mode
- **No app-specific light/dark toggle** — respect the system setting (Light/Dark/Auto); Auto can switch at runtime.
- Dark Mode is **not** a simple inversion. Use semantic colors; for custom colors add a **Color Set asset** with both variants.
- **Contrast floors (explicit):** minimum **4.5:1**; for custom small text **strive for 7:1**.
- **Base vs elevated:** Dark Mode uses a dimmer **base** set and a brighter **elevated** set; the system auto-switches base→elevated when UI comes forward (popover, sheet, multi-window). Prefer system backgrounds so this depth cue works.
- Soften white-background images so they don't glow. Test with **Increase Contrast + Reduce Transparency** (separately + together) — these can *reduce* dark-on-dark contrast.

## 4. Materials — two types, don't confuse them
1. **Liquid Glass** = the functional/chrome layer floating above content (see `ios-liquid-glass-swiftui`). **Don't use it in the content layer.** Exception: transient controls (sliders/toggles) take a glass look only *while being manipulated*.
2. **Standard materials** = differentiation *within* the content layer (app backgrounds, grouped surfaces).

**Standard material levels (iOS), thin→thick:** `.ultraThin`, `.thin`, `.regular` (default), `.thick`. Thicker = more opaque = better contrast for fine text; thinner = more translucent = preserves context. **Choose by semantic need, not apparent color.**

**Vibrancy (always put system vibrant colors on top of materials for legibility):**
- Labels: `.label` (default, highest contrast) → `.secondaryLabel` → `.tertiaryLabel` → `.quaternaryLabel`. **Avoid `quaternaryLabel` on `.thin`/`.ultraThin`** (contrast too low).
- Fills: `.fill` / `.secondaryFill` / `.tertiaryFill` (any material). Separators: single value, any material.

## 5. Liquid Glass color rules (from the Color page)
- Glass has **no inherent color** — it picks up color from content behind it.
- Apply color **sparingly**, for emphasis only (status, primary action). For a primary action, color the **background**, not the symbol/text. Don't color multiple controls' backgrounds.
- Small chrome (toolbars/tab bars): symbols default **monochromatic** (dark over light content, light over dark). Larger elements (sidebars) render more opaque to stay legible.
- Colorful app? Prefer monochromatic bars or a high-differentiation accent.

## 6. Color management
sRGB is fine on most displays; use **Display P3, 16 bits/channel, PNG** on wide-gamut displays. Provide color-space-specific asset variants when very-similar P3 colors or P3 gradients clip on sRGB.

## 7. Greg application
- Greg's tangerine is a **content-layer accent** (primary button fill, key numbers) applied **sparingly** — not on the bars.
- Build surfaces from the **grouped** background set (canvas → grouped card → nested) so hierarchy + dark mode + elevation all come free.
- Keep allergy/safety text at `label` on a solid (`.regular`/`.thick`) surface — never low-vibrancy on a thin material.
- Define every custom Greg color as a Color Set with light+dark+increased-contrast; never hard-code hex in views (the current `Color(hex:)` tokens should become asset-catalog Color Sets before ship for proper dark-mode + contrast adaptation).

Pairs with: `ios-liquid-glass-swiftui`, `ios-motion-and-accessibility` (contrast), `ios-typography`.
