---
name: ios-sf-symbols-and-icons
description: SF Symbols usage (weights, scales, the four rendering modes, fill-vs-outline variants, animations, SF Symbols 7 gradients/Draw, accessibility labels, version-gating) and iOS 26 app icons (layered design, Icon Composer, square-unmasked layers, the six appearances, specs) per Apple HIG. Use when picking icons, choosing rendering modes, or producing an app icon for a native iOS app.
tags: [ios, sf-symbols, icons, app-icon, icon-composer, hig, apple]
---
# SF Symbols & app icons — iOS 26

Source: Apple HIG **SF Symbols** + **App icons** pages (read June 2026; App-icons change log June 8 2026).

## 1. SF Symbols — the system icon library
Thousands of symbols that align automatically with San Francisco text at every weight/size. **Availability is version-gated** — a symbol added in a given year isn't on earlier OSes; check before using newer symbols.
- **Don't** use SF Symbols (or look-alikes) in app icons, logos, or trademarked use.

**Weights (9):** Ultralight → Black, each matching an SF font weight — match a symbol's weight to adjacent text. (Per typography rules, avoid the thin end.)

**Scales (3), relative to cap height:** Small, **Medium (default)**, Large — SwiftUI `.imageScale(.small/.medium/.large)`.

**Rendering modes (4):**
- **Monochrome** — one color to all layers.
- **Hierarchical** — one color, varying opacity per layer (depth).
- **Palette** — two+ explicit colors, one per layer.
- **Multicolor** — intrinsic meaningful colors (leaf green, `trash.slash` red).
- `.automatic` picks the symbol's preferred mode — but verify legibility. Prefer **system colors** so symbols keep adapting to dark mode / vibrancy / accessibility.

**Variants:** outline (most common); **fill** = more emphasis — **iOS tab bars + swipe actions prefer fill**, toolbars take outline; `slash`; `enclosed` (circle/square — better at small sizes). Script-specific variants adapt to device language automatically.

**SF Symbols 7 (iOS-26 era):** **gradients** (smooth linear gradient from one source color, all modes, best at larger sizes) and **Draw On/Off** animation. **Variable color** maps layer coloring to a 0–100% value (capacity/strength/progress) — use for *change*, not depth (use Hierarchical for depth).

**Animations** (all symbols/modes/weights): Appear, Disappear, Bounce, Scale, Pulse, Variable Color, Replace, **Magic Replace** (new default), Wiggle, Breathe, Rotate, **Draw On/Off**. Apply judiciously — too many overwhelm.

**Accessibility:** always provide an **alternative text label** (accessibility description) for VoiceOver. Custom symbols must stay consistent with system symbols (detail, optical weight, alignment) and be Simple/Recognizable/Inclusive.

## 2. App icons — iOS 26 layered + Liquid Glass
iOS/iPadOS/macOS/watchOS icons are now **layered** (a background layer + one or more foreground layers); the system applies **Liquid Glass** attributes (specular highlights, refraction, translucency) that adapt with size and across OS versions.
- **Build with Icon Composer** (in Xcode 26 / Apple Developer site): define background, place foreground layers, apply glass, annotate **default / dark / mono** variants, preview, export.
- **Provide square, UNMASKED layers — the system masks.** iOS/iPadOS/macOS → square layer, system applies the rounded-rectangle "concentric" mask matching the device bezel. **Don't pre-mask or pre-round** — it breaks specular highlights and looks jagged.

**Specs:** iOS/iPadOS/macOS layout = **1024×1024 px**, square, layered, masked to a rounded rectangle.

**Six appearances (iOS/iPadOS/macOS):** default, **dark**, clear (light + dark), tinted (light + dark). The system auto-generates any you don't provide; keep core visual features consistent across all. Base dark on the light icon with complementary colors; colored backgrounds give best dark-icon contrast. Alternate icons each need their own variants and pass App Review.

**Design rules:** embrace simplicity / minimal shapes; consider filled, overlapping shapes with transparency for depth; prefer **vector** (SVG/PDF) layers, PNG for mesh gradients; **let the system add highlights/shadows/blurs/glows** — don't bake them in; full-bleed opaque background; **include text only when essential** (no localization/accessibility, often redundant); prefer illustration over photos; **don't replicate Apple hardware or standard UI components**.

## 3. Greg application
- Tab bar uses **filled** SF Symbols; toolbar uses outline. Match symbol weight to nearby label weight.
- Use **monochrome + tangerine tint** for primary-action symbols; reserve **multicolor/variable color** for nutrition/progress meaning (e.g., variable color on a "remaining calories" ring symbol communicates fill state).
- Every icon-only control needs an accessibility label.
- For the app icon: design a simple layered mark (square, unmasked), let Icon Composer apply glass + generate dark/tinted variants — don't ship a pre-rounded flat PNG.

Pairs with: `ios-color-and-materials` (rendering color), `ios-typography` (weight matching), `ios-components` (where fill vs outline applies).
