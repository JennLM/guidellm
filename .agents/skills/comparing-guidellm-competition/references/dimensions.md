# Comparison dimensions

Use these rows in the matrix. Add a row only when a competitor capability does not fit.

| Dimension | What to record |
| --- | --- |
| Interface | CLI, Python API, YAML/config, container, live UI |
| Load generation | Concurrent, constant rate, Poisson, sync, throughput, sweep, dual rate+concurrency |
| SLO / goodput | How objectives are declared; attainment vs goodput; search for max load under SLO |
| Saturation / knee | Over-saturation stop; knee; adaptive scale |
| Metrics (client) | TTFT, ITL, TPOT, e2e, distributions, timeslices, HTTP/DNS |
| Metrics (server/GPU) | Prometheus scrape, DCGM/pynvml, vLLM/SGLang/TGI server metrics |
| Data sources | HuggingFace, files, synthetic, named corpora, inline YAML |
| Prefix / KV cache | Shared-prefix groups, synthetic prefix controls, hash-aware traces |
| Trace replay | Mooncake, OTEL, WEKA, Azure, Bailian, BurstGPT, raw payload |
| Multi-turn / tools | Chat history, tool calling, agent traces |
| Endpoints | chat, completions, responses, embeddings, rerank, audio, image/video gen, pooling |
| Backends | OpenAI HTTP, in-process engine, websocket, hosted clouds (Bedrock, SageMaker, …) |
| Outputs | console, json, csv, html, png, xlsx, MLflow/W&B/OTel |
| Orchestration | Kubernetes Job vs operator/CRD; multi-URL |
| Extensibility | Registry/plugins; Python API |
