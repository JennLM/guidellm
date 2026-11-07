---
name: bug-complexity
description: >-
  Estimates how complicated each open GitHub issue is to fix, using the size
  scale xs, s, m, l, xl, xxl. Use when the user asks for bug complexity, story
  points, t-shirt size, or how hard an open issue will be to fix, including
  GuideLLM issues in vllm-project/guidellm.
---

# Bug complexity

Size the work required to close each open issue. The size is a story-point estimate of the fix, not of how severe the bug is for users. A one-line crash in a hot path can be `xs`. A mild papercut that needs a new subsystem is `xl` or `xxl`.

Default repository: `vllm-project/guidellm`. If the user names another `owner/repo`, use that repository instead. If they paste issues, size only that text and do not fetch GitHub.

Do not edit issues, open issues, or post comments.

## Get the issues

Open issues only. Drop pull requests.

Prefer the GitHub CLI when it is authenticated:

```bash
gh issue list --repo vllm-project/guidellm --state open --limit 200 --json number,title,labels,body
```

If `gh` is not logged in, the repository is public, so use the GitHub API and drop items that include a `pull_request` field. Follow pagination until a page is short or there is no next link:

```bash
curl -sS "https://api.github.com/repos/vllm-project/guidellm/issues?state=open&per_page=100&page=1"
```

Keep number, title, labels, and body. Read the body before choosing a size. A title is not enough. Read comments only when the body does not say what is broken or what "done" means.

If both `gh` and the API fail with an auth error, stop and ask the user to run `gh auth login`. Do not invent issue numbers, titles, or sizes. After they log in, fetch the list again.

## Choose a size

Use only these values: `xs`, `s`, `m`, `l`, `xl`, `xxl`.

Pick the smallest size whose description is still true. Compare the issue to the size below it and say, in the reasoning, what pushes it up.

| Size | The fix looks like this |
| --- | --- |
| `xs` | The correct change is already obvious: wording, a constant, a label, or a one-line guard. No new behavior to design. |
| `s` | One file or one function. The issue states the wrong behavior and where it happens. A test can copy an existing case. |
| `m` | One subsystem. The fix needs a new branch or a new test, and the issue does not already spell out the code change. |
| `l` | Two subsystems, or the cause is not identified. Closing it changes a CLI flag, a saved result field, or a public default. |
| `xl` | Several subsystems, or the missing behavior needs a small design before anyone can patch it. |
| `xxl` | Closing it is a project: a new backend, a new pipeline, or work that cannot start until a design is agreed. |

A linked pull request that already does the work sizes the remaining review and merge, usually `xs` or `s`. Say that the pull request exists.

Two issues that describe the same fix each get a size. Name the other issue number in the reasoning.

## Write the result

The table the user reads is a Word file in the same place GuideLLM task priority writes its document.

Save a markdown copy at `planning/guidellm/YYYY-MM-DD-bug-complexity.md`. The date is the day the estimate was first made. If that file exists, use `YYYY-MM-DD-bug-complexity-2.md` rather than overwriting it.

Build `planning/guidellm/YYYY-MM-DD-bug-complexity.docx` beside the markdown. Follow [the priority skill's Word and Drive steps](/home/jmulread/my-cursor-claw/.cursor/skills/guidellm-task-priority/references/google-doc.md): a real heading for the title, a Word table with a header row, and issue numbers as text that links to GitHub. Upload that file to the priorities Drive folder named in that reference, then open it as a Google Doc. Put the Google Doc URL at the top of the markdown and in the chat.

If Google sign-in blocks the upload, ask the user to log in, keep the `.docx`, and retry the upload after they log in.

In the document, put a one-line count of each size first, skipping sizes that have zero issues. Then one table, largest size first, then ascending issue number. Columns: Issue, Title, Size, Reasoning.

Reasoning is one sentence. Name the kind of change and why it is not the next smaller size. Do not write a fix plan, a file list, or restatement of the title.

Do not add a second points column. The size value is the estimate.

## Dashboard cell

When an issue dashboard needs a complexity for every issue, the cell shows the size only: `xs`, `s`, `m`, `l`, `xl`, or `xxl`. The hover text is the one-sentence reasoning. Do not put the reasoning in the cell.

In the chat, lead with the document URL and the size count. Do not paste the full table.
