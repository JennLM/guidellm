# Output template

Use this structure. Omit a table row's unknown cells with "not in sources" rather than leaving them blank or guessing.

GuideLLM work is tracked as GitHub issues in `vllm-project/guidellm`, for example `#1125`. Do not put Jira keys in this document.

```markdown
# GuideLLM task priority — YYYY-MM-DD

Google Doc: [url once uploaded]

## Decision
[Two or three sentences: what to do first, which date is driving it, and the main tradeoff.]

## Now
| Rank | Task | Why this rank | Program and date | Feedback tier | GitHub | Owner |
|------|------|---------------|------------------|---------------|--------|-------|
| 1 | ... | ... | ... | High / Secondary / none | #123 or needs an issue | ... |

## Next
| Rank | Task | Why this rank | Program and date | Feedback tier | GitHub | Owner |
|------|------|---------------|------------------|---------------|--------|-------|

## Later
| Task | Why it waits | Feedback tier | GitHub |
|------|--------------|---------------|--------|

## Gaps
- **Task** — needed for [program date or high-priority feedback]. No open issue found.

## Parked issues
- #123 — [title]. No program date and not on either feedback list.

## Conflicts
- **[Task A] vs [Task B]** — [what each source says]. Recommendation: [which one is scheduled first and why, using the tie-break order].

## Sources
- Link index: [path or URL]
- Roadmaps read: [url — milestone date]
- Roadmaps unread: [url — reason]
- Feedback: [path]. High-priority items: N. Secondary items: N.
- GitHub: open issues in vllm-project/guidellm, [count], pulled [time]
- Links skipped as not a roadmap or schedule: [short list]

## Not done
This pass did not open, close, or edit GitHub issues, and it did not edit the source documents.
```
