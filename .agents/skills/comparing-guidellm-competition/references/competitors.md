# Named competitors

Snapshot of the Google Doc “Known competition to guideLLM to compare” (`1Pi7HDi-sny-NNfkGOjK2D_sPnM9kXJwP7YKPdbIRKUI`). Refresh with `scripts/fetch_competitors.sh` before trusting this file.

| Name in the Doc | Canonical repo | Docs to fetch first |
| --- | --- | --- |
| Inference-perf | [kubernetes-sigs/inference-perf](https://github.com/kubernetes-sigs/inference-perf) | README; `docs/goodput.md`; `docs/config.md`; `docs/comparability.md` |
| AIPerf | [ai-dynamo/aiperf](https://github.com/ai-dynamo/aiperf) | README (Features + Supported APIs + tutorial index); GPU telemetry; goodput; Kubernetes |
| Genai-bench | [sgl-project/genai-bench](https://github.com/sgl-project/genai-bench) | README; user guide (tasks, concurrency, Excel, multi-cloud) |

## Baseline (not a competitor)

| Name | Repo |
| --- | --- |
| GuideLLM | [vllm-project/guidellm](https://github.com/vllm-project/guidellm) — this working tree |

## Same-job tools that are not on the Doc

Do not put these in the matrix unless the Google Doc is updated: `vllm bench serve`, GenAI-Perf (AIPerf predecessor), Ray LLMPerf (archived), xk6-llm, llm-d-benchmark (meta-harness).
