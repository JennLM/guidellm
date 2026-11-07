# Tie-break example

This is calibration only. Do not copy these facts into a real ranking.

Sources:

- RhoAI 3.5 GA on 2026-08-20 needs a GuideLLM container image.
- A program roadmap that never names GuideLLM still counts when it schedules a test of the same kind of work. A KV-cache test on 2026-08-01 means GuideLLM's prefix-reuse benchmark has to be finished by that test, and the write-up should say the match is the capability, not a sentence that says "GuideLLM."
- GitHub #1813 is that container image, and it has an assignee.
- High-priority feedback: percentile latency should include scheduler delay. No program date states this.
- Secondary feedback: audio modality support. #900 is open with no milestone. No program date states this.

Result:

1. **Now** — container image. The GA date misses without it, and #1813 is already assigned.
2. **Next / Gap** — latency percentiles. It is high-priority feedback, and no issue was found.
3. **Later** — audio modality. It is secondary feedback. #900 exists, and no program date pulls it forward.

Conflict to write down: users ranked latency above audio, and neither has a date, so latency stays ahead of audio even though audio already has an issue. The container still comes first because the GA date is a harder constraint than the feedback order.
