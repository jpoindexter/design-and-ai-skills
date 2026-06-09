# AI Engineering Skills

**13 reference-grade skills** for production LLM and agent systems — context engineering through inference serving, caching, RAG, evals, observability, and safety.

Grounded in specific systems and papers: vLLM/PagedAttention, FlashAttention, AWQ/GPTQ/SmoothQuant, RAGAS, OWASP LLM Top 10, OpenTelemetry GenAI.

Install instructions, the SKILL.md format spec, and full skill descriptions are in the [root README](../README.md).

---

## Skills

**Context & harness** — [`harness-and-context-engineering`](harness-and-context-engineering/SKILL.md) · [`adaptation-strategies`](adaptation-strategies/SKILL.md)

**Inference & serving** — [`inference-performance`](inference-performance/SKILL.md) · [`inference-caching-and-kv`](inference-caching-and-kv/SKILL.md) · [`quantization-and-model-compression`](quantization-and-model-compression/SKILL.md)

**Reliability & agents** — [`structured-output-and-tool-calling`](structured-output-and-tool-calling/SKILL.md) · [`agent-reliability-and-guardrails`](agent-reliability-and-guardrails/SKILL.md) · [`model-routing-and-fallback`](model-routing-and-fallback/SKILL.md)

**Retrieval & evals** — [`rag-architecture`](rag-architecture/SKILL.md) · [`llm-evals-and-retrieval-quality`](llm-evals-and-retrieval-quality/SKILL.md)

**Ops, cost & safety** — [`llm-observability-and-cost`](llm-observability-and-cost/SKILL.md) · [`llm-safety-and-multitenancy`](llm-safety-and-multitenancy/SKILL.md) · [`production-failure-modes-and-tradeoffs`](production-failure-modes-and-tradeoffs/SKILL.md)

---

## Quick install (Claude Code)

```bash
cp -R ai-engineering-skills/*/ ~/.claude/skills/
```
