# Recommendation rubric

Score each **gap** (competitor yes, GuideLLM no).

| Verdict | When |
| --- | --- |
| **Add** | Helps GuideLLM’s job (SLO-aware eval of a deployment you operate) or is table-stakes in a channel GuideLLM already claims (vLLM production, HF datasets, embeddings). Prefer a thin integration over a rewrite. |
| **Watch** | Useful in a neighbor audience (NVIDIA Dynamo, SGLang, llm-d) or likely to matter in 1–2 releases; do not start now unless a customer/channel asks. |
| **Skip** | Different job (accuracy evals, public hardware leaderboards), hosted-cloud identity stacks, or a large surface that duplicates a competitor’s product rather than GuideLLM’s. |

## Questions to answer in the rationale

1. Whose user is blocked today without this?
2. Does GuideLLM already cover 80% via another mechanism (HF datasets vs named ShareGPT loader; `prefix_tokens` vs `shared_prefix`)?
3. Would adding it pull GuideLLM off SLO-aware serving eval?

## Defaults

- GPU/DCGM + Prometheus server metrics: lean **Add** if still missing — operators correlate latency with device/engine state.
- Rerank if embeddings already exist: lean **Add**.
- Image/video **generation** APIs, MMLU/AIME, Excel+pricing, Kubernetes operator: lean **Skip** or **Watch**.
- Named public datasets GuideLLM can already load via HuggingFace: **Skip** as builtins; document recipes instead.
- Bayesian sweeps of **server** flags: **Watch** — GuideLLM’s goodput/knee profiles already search **client load**.
