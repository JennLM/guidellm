---
name: guidellm-task-priority
description: >-
  Ranks and schedules GuideLLM work into a priority document from the planning
  Google Docs in the GuideLLM priorities Drive folder (roadmap links plus a
  high-priority then secondary feedback list), program test dates for similar
  capabilities even when a roadmap never names GuideLLM, and open issues in
  https://github.com/vllm-project/guidellm. Use when the user asks to
  prioritize GuideLLM, rerun GuideLLM task priority, set sprint or weekly
  order, or schedule GuideLLM against program roadmaps. GuideLLM work tickets
  are GitHub issues, not Jira. If GitHub or that Drive folder is not readable,
  ask the user to log in and then rerun.
---

# GuideLLM task priority

Produce one ranking document the user can use to order GuideLLM work. Program dates decide when work has to land, user feedback decides what users want most, and GitHub issues are the work that already exists. Do not edit GitHub issues, Confluence pages, or the source files.

GuideLLM work tickets live in GitHub: https://github.com/vllm-project/guidellm. They are not Jira tickets. Do not search Jira for the GuideLLM backlog.

## Inputs

A run needs three sources. The priorities folder, the docs last seen there, how to export a private Google Doc, and how to turn a fix version into a calendar date are in [references/sources.md](references/sources.md). Use that file on every run.

Open the priorities folder first and read the planning documents that are in it now. Do not start from a saved document URL and skip the folder. Skip files this skill wrote (`YYYY-MM-DD-task-priority`); those are output, not input.

1. **Link index** — the schedules tab of `GuideLLM schedule planning`, plus every other planning doc in the folder, including `GuideLLM release planning`. Follow every roadmap and schedule link in those docs.
2. **GuideLLM GitHub issues** — open issues in `vllm-project/guidellm`.
3. **User feedback** — the feedback tab of `GuideLLM schedule planning`. A high-priority list comes first, then a secondary list. Keep those lists distinct. The high-priority list is the user's judgment of what matters most.

When the user pastes or attaches sources, use that text for those sources. Still open any roadmap links inside what they gave you. If a source is missing and no default exists, ask once, then continue and record the gap.

If the priorities folder, a document in it, or GitHub is behind a login wall, stop and ask the user to log in. Rerun after they do. Do not publish a ranking that pretends the blocked source was read.

## Read the sources

### Link index and roadmaps

Read a local file directly. For `.docx`, extract paragraph text with the procedure in [references/read-docx.md](references/read-docx.md).

For each roadmap or schedule link:

- `redhat.atlassian.net` Confluence: `cloudId` is `https://redhat.atlassian.net`. The page id is the number in `/pages/<id>/`. Call `getConfluencePage` with `contentFormat` `markdown`.
- Any other `http` or `https` link: fetch the page. If login or permissions block it, record the URL as unread. Do not guess what the page says.
- Skip links that are not a roadmap, schedule, or milestone plan, and list what you skipped.

From each roadmap, keep only facts that are written there:

- Program name
- Milestone name and date, including the date the program plans to test or finish a capability
- The capability being built or tested
- Source URL

A roadmap can set a GuideLLM date even when it never names GuideLLM. If the program is building or testing something GuideLLM already measures or is being asked to measure (benchmarks, workload recipes, multi-turn or agent traffic, KV-cache reuse, prefill/decode, OMNI or multimodal, latency and throughput, regression comparisons), treat that program's test date as the date GuideLLM needs the matching topic finished. Write the match in plain language and cite the roadmap row. Mark the match tentative when the wording is only loosely related.

If a page neither names GuideLLM nor describes work GuideLLM would benchmark, write "No GuideLLM-shaped work on this page." Do not invent a dependency.

### GitHub issues

The work tracker is https://github.com/vllm-project/guidellm. List open issues (not pull requests).

Prefer the GitHub CLI when it is authenticated:

```bash
gh issue list --repo vllm-project/guidellm --state open --limit 100 --json number,title,labels,assignees,milestone,updatedAt,url
```

If `gh` is not logged in, the repo is public, so use the GitHub API and drop items that include a `pull_request` field. Follow pagination until a page is short or there is no next link:

```bash
curl -sS "https://api.github.com/repos/vllm-project/guidellm/issues?state=open&per_page=100&page=1"
```

Keep number, title, labels, assignees, milestone title and due date, and updated date. Labels such as `priority-critical` and `priority-high` are the repo's own priority signal. They are weaker than a dated program milestone and weaker than the high-priority feedback list.

If both `gh` and the API fail with an auth error, stop and ask the user to log in (`gh auth login`). Do not invent issue numbers, assignees, or milestones, and do not finish the ranking as if the issue list succeeded. After they log in, rerun the same list. Only if they explicitly say to continue without GitHub should you rank from the other sources and say that issue coverage is incomplete.

Match an issue to a roadmap need or feedback item when they describe the same work, even if the wording differs. When the match is uncertain, list the candidate issue numbers and mark the match tentative.

### User feedback

Extract a Word document with the procedure in [references/read-docx.md](references/read-docx.md). For a Google Doc, read the tab the user pointed at. Find the high-priority section and the secondary section. Preserve item order inside each section. If you cannot tell which section is the high-priority list, ask once, and do not rank until the user answers.

## Rank

Program dates decide *when* something has to land. The high-priority feedback list decides *what users want most*. GitHub decides *what work already exists* and who is on it. A `priority-*` label is a weak signal next to those two sources.

When sources disagree, use this order:

1. A dated program test or milestone for a capability GuideLLM has to be able to measure by that date. The page does not have to name GuideLLM. The test date is the deadline.
2. An item on the high-priority feedback list.
3. An open GitHub issue that unblocks (1) or (2), especially one already assigned. Name the tradeoff before you recommend stopping it.
4. An item on the secondary feedback list.
5. Undated roadmap themes, and open issues that neither a roadmap nor either feedback list asked for.

Put each item in one bucket:

- **Now** — finish before the next program test date for that kind of work, or before the next GuideLLM milestone that is supposed to contain it.
- **Next** — high-priority feedback, or a later test date, that does not have to finish before the nearest gate.
- **Later** — secondary feedback, or undated work that is still worth keeping.
- **Gap** — a Now or Next need with no GitHub issue. Say "needs an issue." Do not open the issue unless the user asks.
- **Park** — an open issue with no program test for similar work and no place on either feedback list. A GitHub `priority-*` label alone does not keep it in Now.

If more items qualify for Now than the user said the team can take, keep the overflow in Next and say the nearest gate is overloaded. If they did not give capacity, still sequence Now, and state that the sequence assumes no capacity number was provided.

Every rank line cites its evidence: program and date, feedback tier, GitHub issue number, or "not in sources."

## Dashboard cell

When an issue dashboard needs a priority for every issue, the cell shows First, Second, Third, or Fourth. Those labels map from the ranking buckets: Now is First, Next is Second, Later is Third, and Park is Fourth. Gap is for a need that has no issue, so it is not a cell value. The hover text is one sentence. Cite the program and date, the feedback tier, or say it is not in the program schedule or either feedback list. A GitHub `priority-*` label does not raise the bucket. If that label is the only priority signal, say so in the sentence.

## Write the document

Save a markdown copy at `planning/guidellm/YYYY-MM-DD-task-priority.md`. The date in the name is the day that ranking was first made. If that file already exists, use `YYYY-MM-DD-task-priority-2.md` rather than overwriting it. When you keep an earlier ranking, leave its original date in the filename. Do not rename it to the day you copy it. Follow [references/output-template.md](references/output-template.md).

The final output the user reads is a Google Doc. Build the same content as a `.docx` beside the markdown, then upload that file into the GuideLLM Drive folder `https://drive.google.com/drive/folders/1C5F69QCEC7LqDR7Kh4U6RmJBmssTxvV-?usp=drive_link` and open it as a Google Doc. How to build and upload it is in [references/google-doc.md](references/google-doc.md). Put the Google Doc URL at the top of the markdown and in the chat, ahead of the Now list.

If Google sign-in blocks the upload, ask the user to log in, keep the `.docx`, and retry the upload after they log in. Do not stop after the markdown alone.

A short worked tie-break is in [references/example.md](references/example.md). Use it to calibrate ranking, not as content to copy into the user's document.
