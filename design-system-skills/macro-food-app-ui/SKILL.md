---
name: macro-food-app-ui
description: UI/UX patterns for modern macro + food-tracking apps (MyFitnessPal, Cal AI, Lose It, MacroFactor, Lifesum) — the calorie/macro dashboard, the log→remaining loop, fast multi-modal entry (search/barcode/photo/voice), the food diary, weight trend, daily score, and the anti-patterns that make trackers feel like data entry chores. Use when designing or reviewing a nutrition/calorie app's screens; pairs with dense-no-scroll-layout, ios26-hig-patterns, data-visualization.
tags: [nutrition, macro, food-tracking, calorie, health, mobile-ui, patterns]
---
# Macro / food-tracking app UI patterns

Nutrition trackers live or die on **logging friction** and **glanceability**. The user logs many times a day and checks "where am I vs my target" constantly. Every tap between intent and a logged item, and every scroll between opening the app and seeing today's number, is a tax that predicts churn. This skill is the pattern library the category has converged on, plus the differentiators (AI photo, adaptive targets) and the anti-patterns.

The core loop, and the order it should appear on the home screen: **target → what you've eaten → what's remaining → quick way to log more.** Everything else (trends, score, water, streak) is secondary.

---

## 1. The calorie/macro dashboard (home hero)

The single most important component. Conventions:
- **Remaining-centric.** Show calories *remaining* as the big number (Goal − Food + Exercise = Remaining). MyFitnessPal and most apps lead with remaining, not consumed — it answers "can I eat this?".
- **A ring or large numeral** for calories; **three macro bars** (protein/carbs/fat) as `eaten / target g` with a fill. Cal AI's signature is the ring + macro rings; MFP uses a donut + bars.
- Keep it to **one combined card**, not four stacked ones (see dense-no-scroll-layout). Calories hero + 3 macro bars in a single card is the standard.
- Color macros consistently app-wide (e.g., protein green, carbs blue, fat purple) and reuse those colors everywhere that macro appears.
- A compact day strip (M T W T F S S) above the dashboard for date context — horizontal, not a date picker that pushes content down.

## 2. The log → remaining loop

- A persistent, obvious **"+" / "Log" affordance** (FAB, toolbar +, or a prominent button). Cal AI floats a camera-first button; MFP uses a center tab "+".
- After logging, **return to the dashboard with the numbers visibly updated** (remaining drops, bars fill). The feedback *is* the reward. Animate the bar/ring change.
- Meal sections (Breakfast/Lunch/Dinner/Snacks) each with their own running subtotal and per-section "add food".
- "Quick add" (just calories/macros, no food match) and "recently logged"/"frequent" lists to skip search for repeat meals — huge friction win.

## 3. Multi-modal entry (the differentiator race)

Ranked by speed-to-log:
1. **Photo / AI vision** (Cal AI's wedge): snap → AI estimates items + macros → user confirms/edits. The confirm/edit step is mandatory — never auto-save an AI estimate as truth.
2. **Barcode scan:** instant for packaged food; scale by servings on a review screen.
3. **Recent / saved meals / quick-repeat:** one tap to re-log a frequent meal.
4. **Text/voice natural language:** "two eggs and toast" → parsed items.
5. **Search the database:** the fallback; needs verified-food badges + "report incorrect".

Design rule: **always show a review screen before save** for any estimated entry (AI/barcode/voice), with the items, serving, and a hard-stop for allergen conflicts. The model proposes; the user accepts.

## 4. Food diary

- Reverse-chronological or meal-grouped list of **compact rows**: food name · serving · calories, with macros on a second line or trailing. Not cards.
- Swipe actions: delete, edit, copy-to-another-day.
- A per-day total footer and a "complete diary / finish today" action that can show a projection.
- Multi-day navigation via the day strip or a date header with chevrons — never force scrolling through days.

## 5. Trends, score, and engagement (secondary, demote)

- **Weight trend:** a sparkline/line chart with a smoothed trend line (not raw daily noise). Entry via a quick weigh-in. This is the signal adaptive apps use to retarget.
- **Daily nutrition score** (Cal AI / MacroFactor style): a 0–10 or letter grade from nutrient quality — a glanceable "how good was today". Deterministic; an AI one-liner can summarize but must not set the score.
- **Streaks & reminders:** a streak badge + scheduled meal/weigh-in reminders drive retention. Keep the badge small; don't let gamification dominate the hero.
- **Insights:** per-food callouts ("high in sodium", "good source of fiber") computed from the nutrient panel — advisory chips, never blocking.
- All of the above sit *below* the dashboard or behind a segmented switch — they are not the home hero.

## 6. Onboarding (sets the targets)

- Goal (lose/maintain/gain) → stats (sex/height/weight/age/activity) → rate → computed calorie + macro targets, shown with a plain-language rationale.
- Targets are **deterministic** from the profile (Mifflin-St Jeor TDEE × activity ± deficit), with a safe calorie floor. AI may suggest, deterministic math sets.
- Never show "Step X of Y"; use a momentum rail / category labels.

## 7. Anti-patterns (what makes trackers feel like chores)

- **Logging buried behind multiple taps** — the +/camera must be one tap from anywhere.
- **Home screen that scrolls before showing today's number** — the dashboard is above the fold, always.
- **Auto-saving AI/estimated entries without review** — destroys trust and accuracy.
- **Four stacked single-metric cards** — combine into the dashboard (see dense-no-scroll-layout).
- **Raw daily weight as the trend** — show the smoothed trend or users quit over water-weight noise.
- **Gamification over function** — confetti and badges can't paper over slow logging.
- **Manual exercise logging treated as core** — for a food-first app, pull activity from HealthKit read-only; don't make the user log workouts.
- **Decimal/jittery numbers** — round calories/macros to integers; never show "284.6 cal".

## 8. Review checklist

- [ ] Home leads with remaining calories + 3 macro bars in one combined card, above the fold.
- [ ] Logging is one tap from the home screen; photo/barcode/recent/search all reachable fast.
- [ ] Estimated entries (AI/barcode/voice) hit a review screen with allergen hard-stop before save.
- [ ] Diary is compact rows with swipe edit/delete + per-day total.
- [ ] Trend uses a smoothed line; weight entry is quick.
- [ ] Score/streak/insights are deterministic, glanceable, and demoted below the hero.
- [ ] Targets derived deterministically from the profile with a calorie floor.
- [ ] Macro colors consistent app-wide; calories/macros rounded to integers.
