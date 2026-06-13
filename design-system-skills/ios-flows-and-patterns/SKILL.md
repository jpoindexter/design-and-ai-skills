---
name: ios-flows-and-patterns
description: Apple HIG behavioral patterns for native iOS — onboarding, launch screens, loading, modality decisions, feedback, settings, search, privacy & permission flows (purpose strings, priming screens, ATT), account deletion, in-app purchase, ratings, notifications — plus motion/reduce-motion, haptics (UIFeedbackGenerator patterns), and the accessibility floors (contrast AA, touch targets, Dynamic Type 200%, VoiceOver). Use when designing any flow, permission prompt, empty/loading state, or feedback moment on iOS.
tags: [ios, patterns, onboarding, permissions, privacy, haptics, accessibility, motion, hig]
---
# iOS flows, patterns & behavior — HIG (iOS 26)

Source: Apple HIG **Patterns**, **Motion**, **Accessibility**, **Playing haptics** pages (read June 2026). `ios-components` covers the controls; this covers *flows and behavior*.

## Onboarding & launch
- Onboarding is **optional, skippable, fast, fun** — and happens *after* launch, not as part of it. **Teach by doing**, not slideshows; prefer **contextual tips (TipKit)** over one big flow. Don't re-show a skipped tutorial. Postpone nonessential setup; provide good defaults so people start immediately. No licensing/disclaimers in onboarding.
- **Permission timing:** integrate a permission request into onboarding **only if the app can't function without that data**; otherwise request it **when the person first uses the feature that needs it.** Never request at launch unless the reason is self-evident (a maps app needing location).
- **Launch screen** = a fast-launch illusion, *not* branding/onboarding. **Make it nearly identical to the first real screen** (match orientation + light/dark); **no text** (won't localize); no logos unless they're a fixed part of the first screen. Restore previous state on relaunch.

## Loading
- *"The best content-loading experience finishes before people become aware of it."* **Show placeholder content immediately** (text/graphics/animation), replace as data arrives — never a blank screen (reads as broken). Load in the background. Use a **determinate** indicator when duration is known, indeterminate when not.

## Modality, feedback, settings
- **Modality decision:** full-screen modal for in-depth/complex tasks; sheet/popover for a scoped task tied to current context; alert for critical info. Keep modal tasks short; always provide an obvious dismissal; confirm before losing content; **one modal at a time.**
- **Feedback:** use **multiple channels — color, text, sound, haptics** — so it lands whether silenced, looked-away, or on VoiceOver. Put status near the thing it describes. **Warn before unexpected irreversible loss; don't warn when loss is the expected result.** Mostly tell people when something **fails** (success is assumed). Use alerts judiciously.
- **Settings:** ship **great defaults** so most people change nothing; **minimize the number of settings**; don't ask for info you can detect; respect (don't duplicate) systemwide settings; put task-specific options *in the screen they affect*, not buried in a settings page.

## Privacy & permissions (consolidated Privacy page)
- **Data minimization** — request access only to what a feature actually needs, as specifically as possible; process on-device where possible. Provide App Store privacy details.
- **Purpose strings:** complete sentence, specific, sentence case, active voice, ends with a period. ✅ *"The app records during the night to detect snoring sounds."* ❌ *"Microphone access is needed for a better experience."*
- **Pre-permission (priming) screen — strict:** **one button only** ("Continue"/"Next", **not "Allow"**), no cancel/skip, must lead straight to the system alert. Never mislead or imitate the system alert.
- **App Tracking Transparency** rejection traps: incentivizing permission, withholding features until allowed, imitating/annotating the system alert, an "Allow"-style button.
- **Account deletion (App Store gate):** if you create accounts you must let people **delete** (not just deactivate) in-app, or via a **direct, easy-to-find link** — *not buried in the Privacy Policy*. Note: auto-renewable subscriptions keep billing through Apple until canceled, regardless of deletion.
- **Auth:** prefer **Sign in with Apple** / passkeys; label the method ("Sign In with Face ID"); store secrets in the keychain; don't invent custom auth.

## In-app purchase, ratings, notifications
- **IAP:** let people experience the app first; **show total price**; use the **default system confirmation sheet** (don't modify/replicate); always make canceling easy; IAP is for digital goods (Apple Pay for physical/services/donations).
- **Ratings:** only after demonstrated engagement, **never on first launch / in onboarding**; ≥1–2 weeks between requests; use the **system prompt** (`RequestReviewAction`, capped 3×/365 days) — don't replicate it.
- **Notifications:** get permission first. Four interruption levels — **Passive / Active (default) / Time Sensitive / Critical** (Critical needs an entitlement; extremely rare). Represent urgency **honestly**; **never use Time Sensitive for marketing**; provide an in-app notification-settings screen.

## Motion
- Add motion **purposefully**; gratuitous animation distracts/causes discomfort. Make it optional and **never the only way** to convey important info (pair with haptics/audio). Feedback motion = realistic, brief, precise; generally avoid motion on frequent interactions; let people cancel/skip animations.
- **Reduce Motion (when on):** tighten springs to cut bounce; track animation to the user's gesture; **replace x/y/z transitions with fades**; avoid animating depth changes and blurs.

## Haptics (UIFeedbackGenerator)
- **Use system patterns per their documented meaning** — don't repurpose one (a "failure" haptic for "success"). Be **consistent** (clear cause→effect). **Complement** visual + audio (match intensity, sync timing). **Don't overuse** — frequent haptics tire; the best is often felt only in its absence. Prefer **short** haptics for discrete events. Make them optional. Beware side effects (vibration can disrupt camera/gyroscope/mic).
- Standard patterns: **Notification** (Success/Warning/Error), **Impact** (Light/Medium/Heavy/Rigid/Soft), **Selection** (value changing, e.g. picker). Custom via Core Haptics (transient vs continuous; sharpness + intensity).

## Accessibility floors (non-negotiable for ship)
- **Contrast (WCAG AA):** ≤17 pt → **4.5:1**; 18 pt → **3:1**; any bold → **3:1**. Provide a higher-contrast scheme under Increase Contrast if you can't meet it by default. Check light + dark.
- **Touch targets:** **default 44×44 pt, minimum 28×28 pt** (iOS/iPadOS). ~12 pt padding around bezeled controls, ~24 pt around un-bezeled ones.
- **Text scaling:** support enlargement to **≥200%** via **Dynamic Type**; minimize truncation; stack layouts at large sizes; keep primary elements near the top.
- **Don't convey info by color alone**; prefer system colors (accessible variants auto-adapt). **Label every interactive element** for VoiceOver. Provide non-gesture alternatives to every gesture. Respect Reduce Motion / Dim Flashing Lights. Audit with **Accessibility Inspector**; declare support via **Accessibility Nutrition Labels**.

## Greg application (safety-critical)
- **Allergy hard-stops:** deliver via **multiple channels** (red + icon + text + Error haptic), in the solid content layer, with a non-color signal — never color alone. This is a true alert/blocking case.
- **AI proposals → user accepts:** every adaptive target change is a *proposal* the user confirms; success is quiet, failures are surfaced. Targets/macros need deterministic validation before display (project rule).
- **Permissions:** request camera (barcode/photo) and mic (voice log) **at first use of that modality**, each with a specific purpose string and a "Continue"-only priming screen if needed — never at launch.
- **Account deletion + data export** must be in-app and easy to find (launch gate).
- Use **Selection** haptics on the WeekStrip/picker, **Success** on a confirmed log, **Error** on an allergy stop — consistently, sparingly.

Pairs with: `ios-components` (the controls), `ios-color-and-materials` (contrast), `onboarding-and-empty-states`, `ethical-design-and-dark-patterns`.
