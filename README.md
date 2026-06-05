# Design & AI Engineering Skills

**40 reference-grade skills** for product design and production AI engineering — portable
`SKILL.md` files that install into Claude Code, Codex, or any agent that reads a skills
directory. Depth over fluff: real numbers, formulas, code, comparison tables, do/don't,
named failure modes, and attributions to the actual standards and systems.

Two libraries:

## 🎨 `design-system-skills/` — 27 skills
Design systems and UX for any screen (web · iOS/Android · desktop · mobile · TV · watch).

**Foundations:** design-tokens · typography-system · color-and-elevation · grid-and-spacing ·
iconography-and-imagery
**Structure:** atomic-design · layout-and-composition · components-and-states ·
design-system-governance · design-system-frameworks (Material 3 / HIG / Fluent / Carbon /
Tailwind / shadcn / Radix)
**Interaction & device:** interaction-and-motion · forms-and-data-entry ·
responsive-and-multi-device · platform-conventions
**UX & inclusion:** usability-heuristics (Nielsen / Norman / Shneiderman / Rams) ·
laws-of-ux-and-psychology (Fitts / Hick / Doherty / Peak-End) · ux-writing-and-content ·
accessibility-and-inclusive-design · inclusive-design · information-architecture-and-navigation ·
data-visualization · ethical-design-and-dark-patterns · performance-and-perceived-speed ·
onboarding-and-empty-states · multimodal-voice-and-haptics · internationalization-and-localization ·
brand-identity-and-design-principles

## 🤖 `ai-engineering-skills/` — 13 skills
Production LLM & agent engineering (vLLM/PagedAttention, AWQ/GPTQ, RAGAS, OWASP LLM Top 10).

harness-and-context-engineering · adaptation-strategies (fine-tune vs ICL vs RAG vs distill) ·
inference-performance · inference-caching-and-kv · quantization-and-model-compression ·
structured-output-and-tool-calling · agent-reliability-and-guardrails · model-routing-and-fallback ·
rag-architecture · llm-evals-and-retrieval-quality · llm-observability-and-cost ·
llm-safety-and-multitenancy · production-failure-modes-and-tradeoffs

## View

Open **`index.html`** for the landing page, or each library's `index.html` directly
(self-contained, `file://`-safe — no server). Grouped sidebar, filter, collapsible cards.

## Install

Each `<slug>/SKILL.md` is a standard skill file. To use one:

```bash
# Claude Code
cp -R design-system-skills/typography-system ~/.claude/skills/

# or install a whole library
cp -R design-system-skills/*/ ~/.claude/skills/
cp -R ai-engineering-skills/*/ ~/.claude/skills/
```

Codex / other agents: copy `<slug>/` into that agent's skills directory. No build step.

## Regenerate the viewers

```bash
python3 scripts/build-skills-index.py ai-engineering-skills   # needs `mistune`
python3 scripts/build-design-skills-index.py                  # design library
```

## License

MIT — use, adapt, share.
