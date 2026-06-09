# Design & AI Engineering Skills

**40 reference-grade skills** for product design and production AI engineering — self-contained `SKILL.md` files that load into Claude Code, Codex, or any agent that reads a skills directory.

Two libraries: **27 design-system skills** covering the full UX/design canon, and **13 AI engineering skills** covering production LLM and agent systems.

---

## What these are

Each skill is a single `SKILL.md` file with a YAML frontmatter block and a deep reference body. The body is written as an authoritative reference, not a tips list: real numbers, formulas, comparison tables, copy-pasteable code, do/don't pairs, named failure modes, and attribution to the actual standards and papers (Nielsen/Norman/WCAG, vLLM/PagedAttention, RAGAS, OWASP LLM Top 10, W3C DTCG, and so on).

When a skill is installed, the agent loads the full content into its context at the start of the relevant task — so it works from the actual standard, not a summary of a summary.

---

## SKILL.md format

```yaml
---
name: slug-matching-folder-name
description: One-line summary used by the agent to decide relevance.
tags: [category, topic, subtopic]
---
# Title

Body — markdown, tables, code blocks.
```

**Frontmatter fields:**
| Field | Required | Notes |
|---|---|---|
| `name` | yes | Must match the containing folder name exactly |
| `description` | yes | Used for skill discovery; be specific |
| `tags` | yes | Array of lowercase strings |

**Body conventions used in this library:**
- Sections numbered (§1, §2…) with a clear heading
- Comparison tables for any decision with >2 options
- Concrete numbers (budgets, thresholds, sizes, timings) wherever they exist
- Explicit do/don't pairs for the most common mistakes
- Named failure modes, not vague warnings
- Attribution to the originating standard, paper, or framework (with year where useful)

---

## Repository structure

```
design-and-ai-skills/
├── README.md                        ← you are here
├── index.html                       ← root viewer (both libraries)
├── scripts/
│   ├── build-skills-index.py        ← rebuild ai-engineering-skills/index.html
│   └── build-design-skills-index.py ← rebuild design-system-skills/index.html
├── design-system-skills/
│   ├── README.md                    ← skill list for this library
│   ├── index.html                   ← standalone viewer
│   └── <slug>/SKILL.md              ← one folder per skill (27 total)
└── ai-engineering-skills/
    ├── README.md                    ← skill list for this library
    ├── index.html                   ← standalone viewer
    └── <slug>/SKILL.md              ← one folder per skill (13 total)
```

---

## Design System Skills — 27 skills

For any screen: web, iOS/Android, macOS/Windows, tablet, TV, watch, foldable. Current to 2025–2026 standards (WCAG 2.2, Material 3, Apple HIG, W3C DTCG, OKLCH, container queries, view transitions).

### Foundations

| Skill | What it covers |
|---|---|
| [`design-tokens`](design-system-skills/design-tokens/SKILL.md) | W3C DTCG format, 3-tier primitive→semantic→component model, Style Dictionary v4, Figma↔code parity, multi-brand theming |
| [`typography-system`](design-system-skills/typography-system/SKILL.md) | Modular and fluid scales, `clamp()`, variable fonts, OpenType, baseline rhythm, accessible ramps, cross-platform tokens |
| [`color-and-elevation`](design-system-skills/color-and-elevation/SKILL.md) | OKLCH ramps, WCAG/APCA contrast, semantic tokens, elevation-as-lightness dark mode, copy-pasteable CSS |
| [`grid-and-spacing`](design-system-skills/grid-and-spacing/SKILL.md) | 8pt spacing scale, column/baseline grids, responsive breakpoints, modern CSS Grid and container queries |
| [`iconography-and-imagery`](design-system-skills/iconography-and-imagery/SKILL.md) | Icon grids, optical sizing, variable axes, SVG delivery, aspect ratios, art direction, modern image formats |

### Structure

| Skill | What it covers |
|---|---|
| [`atomic-design`](design-system-skills/atomic-design/SKILL.md) | Brad Frost's atoms→molecules→organisms→templates→pages, Figma/code component tree organization, abstraction levels |
| [`layout-and-composition`](design-system-skills/layout-and-composition/SKILL.md) | Visual hierarchy, Gestalt, alignment, whitespace, scanning patterns, intrinsic CSS (Grid/Flexbox/subgrid/`:has`) |
| [`components-and-states`](design-system-skills/components-and-states/SKILL.md) | Component anatomy, full interaction-state matrix, variants vs sizes vs states, sizing tokens, headless/data-state patterns |
| [`design-system-governance`](design-system-skills/design-system-governance/SKILL.md) | Operating models, contribution and release process, Figma↔code parity, documentation, adoption metrics, anti-patterns |
| [`design-system-frameworks`](design-system-skills/design-system-frameworks/SKILL.md) | Material 3, Apple HIG, Fluent 2, Carbon, Polaris, Primer, Ant, Spectrum; Tailwind, shadcn/ui, Radix, React Aria; adopt-vs-adapt decision |

### Interaction & device

| Skill | What it covers |
|---|---|
| [`interaction-and-motion`](design-system-skills/interaction-and-motion/SKILL.md) | Duration scales, easing tokens, choreography, view transitions, scroll-driven animations, `@starting-style`, `prefers-reduced-motion` |
| [`forms-and-data-entry`](design-system-skills/forms-and-data-entry/SKILL.md) | Single-column layout, persistent labels, input type + keyboard + autocomplete per field, `:user-invalid` validation, multi-step wizards |
| [`responsive-and-multi-device`](design-system-skills/responsive-and-multi-device/SKILL.md) | Mobile-first breakpoints, fluid `clamp()` type, container queries, logical properties, `dvh`/safe-area, phone/tablet/TV/watch/foldable |
| [`platform-conventions`](design-system-skills/platform-conventions/SKILL.md) | iOS/HIG, Android/Material 3, macOS, Windows 11 Fluent — concrete numbers, comparison tables, adapt-vs-custom-brand decision |

### UX & inclusion

| Skill | What it covers |
|---|---|
| [`usability-heuristics`](design-system-skills/usability-heuristics/SKILL.md) | Nielsen's 10 heuristics, Norman's fundamentals, Shneiderman's 8 golden rules, Rams' 10 principles, heuristic evaluation method |
| [`laws-of-ux-and-psychology`](design-system-skills/laws-of-ux-and-psychology/SKILL.md) | Fitts, Hick-Hyman, Miller, Jakob, Tesler, Postel, Doherty, Peak-End, behavioral econ cluster — each with origin, UI application, design rule, pitfall |
| [`ux-writing-and-content`](design-system-skills/ux-writing-and-content/SKILL.md) | Voice and tone systems, every UI string type with before/after, terminology consistency, inclusive language, localization readiness |
| [`accessibility-and-inclusive-design`](design-system-skills/accessibility-and-inclusive-design/SKILL.md) | WCAG 2.2 AA/AAA, APCA, keyboard/screen-reader/touch/motor, forms, motion/cognition, testing, EAA/Section 508 legal floor |
| [`inclusive-design`](design-system-skills/inclusive-design/SKILL.md) | Microsoft's 3 principles + Persona Spectrum, social model of disability, cognitive/neurodivergent/sensory/cultural/economic/age patterns beyond WCAG |
| [`information-architecture-and-navigation`](design-system-skills/information-architecture-and-navigation/SKILL.md) | Organization/labeling/navigation/search systems, taxonomy depth-vs-breadth, nav patterns per device, wayfinding, card sort/tree test/first-click |
| [`data-visualization`](design-system-skills/data-visualization/SKILL.md) | Perceptual encoding ranking, chart-by-intent selection, data color scales, Tufte's data-ink discipline, accessible charts, interaction patterns |
| [`ethical-design-and-dark-patterns`](design-system-skills/ethical-design-and-dark-patterns/SKILL.md) | Brignull/Mathur dark-pattern taxonomy, every pattern with example + fix, consent/privacy UX, attention ethics, FTC/GDPR/DSA legal exposure |
| [`performance-and-perceived-speed`](design-system-skills/performance-and-perceived-speed/SKILL.md) | Core Web Vitals (LCP/INP/CLS budgets and fixes), optimistic UI, skeletons, prefetch-on-intent, loading states, field vs lab measurement at p75 |
| [`onboarding-and-empty-states`](design-system-skills/onboarding-and-empty-states/SKILL.md) | Every view state (empty/loading/error/offline/success/blocked), first-run flows, show-don't-tell, seed data, activation to aha moment |
| [`multimodal-voice-and-haptics`](design-system-skills/multimodal-voice-and-haptics/SKILL.md) | Touch/visual/voice/audio/haptic modality combinations, conversational/LLM-agent UX, voice error recovery, iOS/Android haptics, TV/watch/AR |
| [`internationalization-and-localization`](design-system-skills/internationalization-and-localization/SKILL.md) | Text expansion, RTL/bidi with CSS logical properties, `Intl` formatting, ICU pluralization, script typography, pseudolocalization, translation workflow |
| [`brand-identity-and-design-principles`](design-system-skills/brand-identity-and-design-principles/SKILL.md) | Opinionated design principles, logo systems, attributes-to-visuals translation, brand-in-product, brand→token bridge, guidelines, rebrands |

---

## AI Engineering Skills — 13 skills

For engineers shipping LLM and agent systems in production. Grounded in specific systems and papers: vLLM/PagedAttention, FlashAttention, AWQ/GPTQ/SmoothQuant, RAGAS, OWASP LLM Top 10, OpenTelemetry GenAI.

### Context & harness

| Skill | What it covers |
|---|---|
| [`harness-and-context-engineering`](ai-engineering-skills/harness-and-context-engineering/SKILL.md) | The control loop, tools, memory, retries, budgets; context as a managed token budget; lost-in-the-middle, context rot, just-in-time retrieval, compaction, sub-agent isolation |
| [`adaptation-strategies`](ai-engineering-skills/adaptation-strategies/SKILL.md) | Choosing between ICL, RAG, fine-tuning (LoRA/QLoRA/DPO), and distillation; data requirements; catastrophic forgetting; combining methods |

### Inference & serving

| Skill | What it covers |
|---|---|
| [`inference-performance`](ai-engineering-skills/inference-performance/SKILL.md) | TTFT/TPOT/throughput, prefill vs decode, the roofline model, continuous batching, PagedAttention, chunked prefill, disaggregation, FlashAttention, GPU sizing |
| [`inference-caching-and-kv`](ai-engineering-skills/inference-caching-and-kv/SKILL.md) | Anthropic `cache_control`, OpenAI prefix caching, Gemini implicit/explicit; semantic caching; KV-cache internals (PagedAttention, RadixAttention, eviction, multi-tenant safety) |
| [`quantization-and-model-compression`](ai-engineering-skills/quantization-and-model-compression/SKILL.md) | FP8/INT8/INT4, GPTQ/AWQ/SmoothQuant/NF4/GGUF k-quants, KV quantization, speculative decoding (Medusa/EAGLE/n-gram), distillation, quality cliffs |

### Reliability & agents

| Skill | What it covers |
|---|---|
| [`structured-output-and-tool-calling`](ai-engineering-skills/structured-output-and-tool-calling/SKILL.md) | JSON mode, constrained/grammar-guided decoding, `json_schema` coercion, Zod/Pydantic validation, validate→repair→escalate→fallback loop, idempotency for retries |
| [`agent-reliability-and-guardrails`](ai-engineering-skills/agent-reliability-and-guardrails/SKILL.md) | Plan→act→observe failure physics, five budgets (iteration/tool-call/token/wall-clock/cost), runaway prevention, circuit breakers, three guardrail layers, checkpoint/resume |
| [`model-routing-and-fallback`](ai-engineering-skills/model-routing-and-fallback/SKILL.md) | Routing by cost/latency/quality, cascade escalation, multi-provider fallback, circuit breakers, hedging, degraded-mode UX |

### Retrieval & evals

| Skill | What it covers |
|---|---|
| [`rag-architecture`](ai-engineering-skills/rag-architecture/SKILL.md) | Full ingest→chunk→embed→index→retrieve→rerank→assemble→generate pipeline, chunking strategies, hybrid search, reranking, context assembly, failure modes |
| [`llm-evals-and-retrieval-quality`](ai-engineering-skills/llm-evals-and-retrieval-quality/SKILL.md) | Golden/regression/adversarial eval sets, LLM-as-judge biases, recall@k/MRR/nDCG, grounding/faithfulness/attribution, RAGAS scoring, CI gates |

### Ops, cost & safety

| Skill | What it covers |
|---|---|
| [`llm-observability-and-cost`](ai-engineering-skills/llm-observability-and-cost/SKILL.md) | Distributed traces and spans, OpenTelemetry GenAI conventions, drift detection, per-feature/tenant/user cost attribution, LangSmith/Langfuse/Phoenix/Helicone |
| [`llm-safety-and-multitenancy`](ai-engineering-skills/llm-safety-and-multitenancy/SKILL.md) | OWASP LLM Top 10, direct/indirect prompt injection, privilege separation, dual-LLM pattern, data-leakage prevention, cross-tenant cache/index/memory isolation |
| [`production-failure-modes-and-tradeoffs`](ai-engineering-skills/production-failure-modes-and-tradeoffs/SKILL.md) | Full failure taxonomy (symptom/root-cause/detection/mitigation), latency/quality/cost/reliability tradeoff map, production-readiness checklist, incident response |

---

## Install

### Fresh clone (recommended)

```bash
git clone https://github.com/jpoindexter/design-and-ai-skills
cd design-and-ai-skills
./bootstrap.sh
```

`bootstrap.sh` does two things in one step:
1. Installs all 40 skills to `~/.claude/skills/`
2. Wires a `post-merge` git hook so future `git pull`s auto-reinstall

Reload Claude Code after running. You're done — no manual steps needed after this.

### Existing clone / manual install

```bash
./install.sh
```

Finds every `SKILL.md` under `design-system-skills/` and `ai-engineering-skills/` and copies each to `~/.claude/skills/<slug>/`. Use this if you cloned before `bootstrap.sh` existed, or want to reinstall without pulling.

Preview what will be installed first:

```bash
./install.sh --dry-run
```

### Keeping skills up to date

Once `bootstrap.sh` has been run once, `git pull` handles everything:

```bash
git pull  # post-merge hook fires automatically → all 40 skills reinstalled
```

No manual `install.sh` needed after a pull.

### Install a single skill

```bash
cp -R design-system-skills/usability-heuristics ~/.claude/skills/
```

### Other agents

Each `<slug>/` folder contains one `SKILL.md`. Copy the folder into whatever directory your agent reads for skills. The format (frontmatter + markdown body) is not Claude-specific — any agent that can read a skills directory with YAML frontmatter will work.

---

## Browse

Each library ships a self-contained `index.html` viewer — no server, no build, works from `file://`.

| Viewer | Path |
|---|---|
| Both libraries | `docs/index.html` |
| Design system skills | `docs/design-system-skills.html` |
| AI engineering skills | `docs/ai-engineering-skills.html` |

Open any of them directly in a browser. Grouped sidebar, filter box, collapsible skill cards.

---

## Regenerate the viewers

After adding or editing a skill, rebuild the corresponding `index.html`. Requires `mistune`:

```bash
pip install mistune

# Rebuild AI engineering viewer → docs/ai-engineering-skills.html
python3 scripts/build-skills-index.py ai-engineering-skills

# Rebuild design system viewer → docs/design-system-skills.html
python3 scripts/build-design-skills-index.py
```

---

## Adding a skill

1. Create `<library>/<slug>/SKILL.md` — `slug` must be kebab-case and match the `name:` in frontmatter.
2. Fill in the frontmatter (`name`, `description`, `tags`).
3. Write the body. Conventions: numbered sections, comparison tables for multi-option decisions, concrete numbers where they exist, attribution to originating standards/papers, named failure modes, do/don't pairs.
4. Rebuild the viewer for that library (see above).
5. Add the skill to this README and to `<library>/README.md`.

---

## License

MIT — use, adapt, share.
