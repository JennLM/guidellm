---
name: comparing-guidellm-competition
description: Compare GuideLLM's current capabilities against named major competitors and publish a dated gap analysis Google Doc to the shared Drive competition folder. Use when the user asks for competitive functionality comparison, feature gaps vs AIPerf, inference-perf, or genai-bench, what to add to GuideLLM, or to refresh the dated compare document.
compatibility: Requires gws authenticated to write the competition Drive folder. Network access to GitHub/docs for live competitor inventories.
metadata:
  author: guidellm
  version: "1.0"
---

# Comparing GuideLLM competition

Produce a **dated functionality comparison** and **always publish it as a Google Doc** in the shared Drive competition folder: what named competitors can do that GuideLLM cannot, and whether GuideLLM should add it.

## Destination

- Folder URL: https://drive.google.com/drive/folders/1cTkqKcKgetyJL2CSIoLD4RTFDTjIMywX
- Folder ID: `1cTkqKcKgetyJL2CSIoLD4RTFDTjIMywX`
- Folder name: `competition`
- Override with `GUIDELLM_COMPETITION_DRIVE_FOLDER` if needed.
- Document title: `GuideLLM functionality compare — YYYY-MM-DD`

This skill is **gap analysis**, not landscape watch. For “are there new tools?”, use `guidellm-competition-watch`.

## Competitor list

Canonical source (Google Doc, owned by the GuideLLM team):

https://docs.google.com/document/d/1Pi7HDi-sny-NNfkGOjK2D_sPnM9kXJwP7YKPdbIRKUI/edit

File ID: `1Pi7HDi-sny-NNfkGOjK2D_sPnM9kXJwP7YKPdbIRKUI`

1. Refresh the list from that Doc when `gws` is available:

   ```bash
   bash scripts/fetch_competitors.sh
   ```

2. If `gws` cannot read the Doc, use [references/competitors.md](references/competitors.md) and say the snapshot may be stale.

Do not add extra “competitors” from memory. If a search finds a same-job tool that is not on the list, mention it once under **Out of scope this run**, do not fold it into the matrix.

## Workflow

Copy and track:

```
- [ ] Date (`date +%Y-%m-%d`)
- [ ] Refresh competitor list
- [ ] Inventory GuideLLM from this repo (registries + docs, not README marketing)
- [ ] Inventory each competitor from its current docs/README
- [ ] Build the matrix and gap list
- [ ] Score each gap add / watch / skip
- [ ] Write the dated report (local markdown + HTML)
- [ ] Publish the Google Doc to the competition Drive folder
- [ ] Return the Doc URL
```

### 1. Date the run

```bash
date +%Y-%m-%d
```

Do not guess the date.

### 2. Inventory GuideLLM from this tree

Read registries and guides, not the README comparison table (it goes stale).

| Area | Where |
| --- | --- |
| Backends | `src/guidellm/schemas/backends/` (`@BackendArgs.register`) |
| Data | `src/guidellm/schemas/data/` (`@DataArgs.register`) |
| Profiles | `src/guidellm/benchmark/profiles/` (`@ProfileArgs.register`) |
| Constraints | `src/guidellm/schemas/scheduler/constraints/` |
| Outputs | `@BenchmarkOutputArgs.register`; `docs/en/guides/outputs.md` |
| SLO / goodput | `docs/en/guides/service_level_objectives.md` |
| Other guides | `docs/en/guides/` (embeddings, traces, multimodal, knee, OSD) |

A capability counts only with a registered kind, a guide, or both.

### 3. Inventory each competitor from live docs

Fetch each repo’s README plus feature/docs index. Prefer current docs over GuideLLM’s older comparison table.

Repos and starting URLs are in [references/competitors.md](references/competitors.md).

### 4. Compare on fixed dimensions

Use [references/dimensions.md](references/dimensions.md). Every matrix row is one dimension. Cells are short and evidenced (doc URL or registry kind). `—` means not found, not “probably not”.

### 5. Recommend add / watch / skip

Score **only gaps** (competitor has it, GuideLLM does not). Use [references/recommendation-rubric.md](references/recommendation-rubric.md).

GuideLLM’s job is **SLO-aware evaluation of a deployment you operate** (Python API, Hugging Face datasets, vLLM/OpenAI-compatible serving). Do not recommend cloning a competitor’s entire surface.

### 6. Write the dated report

Local working copies (optional, for the agent):

`.tmp-planning/guidellm-functionality-compare-YYYY-MM-DD.md`

Follow [assets/report-template.md](assets/report-template.md). Fill every section. Do not leave “TBD”.

Convert to simple HTML (`h1`–`h3`, `p`, `table`, `ul`, `a`, `strong`, `code`):

```bash
python3 scripts/md_to_html.py \
  .tmp-planning/guidellm-functionality-compare-YYYY-MM-DD.md \
  .tmp-planning/guidellm-functionality-compare-YYYY-MM-DD.html
```

### 7. Publish the Google Doc

This step is required. Do not stop at a local markdown file.

```bash
bash scripts/publish_gdoc.sh \
  .tmp-planning/guidellm-functionality-compare-YYYY-MM-DD.html \
  "GuideLLM functionality compare — YYYY-MM-DD"
```

The script uploads HTML to Drive, converts it to a Google Doc, and parents it in the competition folder. Print the returned `webViewLink`.

If `gws` auth fails, stop and tell the user to run `gws auth login`. Do not dump credentials. Do not treat the local markdown as the deliverable.

## Output in chat

Give the Google Doc URL first. Then 5–8 bullets: the highest-priority **Add** items and any **Skip** that is easy to over-build. Do not paste the full matrix into chat.

## Common mistakes

- Treating archived or accuracy-eval tools as the named list.
- Scoring from GuideLLM’s README table instead of live competitor docs.
- Recommending MMLU/AIME, generic HTTP load testers, or a Kubernetes operator just because AIPerf has one.
- Calling synthetic `prefix_tokens` a miss for “shared prefix” without checking GuideLLM’s prefix controls and Mooncake/WEKA hash replay.
- Recommending “add everything AIPerf has.”
