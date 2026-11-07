# Standing sources

Use these when the user asks to run GuideLLM priority again and does not give new files. If they give a different link, use that instead. Re-read every source on each run. Do not copy ranks out of an older `planning/guidellm/` file.

## Where to look

The documents to read live in the GuideLLM priorities folder, the same folder the finished priority file is uploaded to:

https://drive.google.com/drive/folders/1C5F69QCEC7LqDR7Kh4U6RmJBmssTxvV-?usp=drive_link

On every run, open that folder in the signed-in browser and list the files that are there now. Read each planning Google Doc in the folder. Follow the roadmap and schedule links inside those docs. Skip files this skill wrote, named like `YYYY-MM-DD-task-priority`. Those are earlier outputs, not sources.

If the folder contains a planning doc that is not in the last-seen list below, read it. If a last-seen doc is no longer in the folder, do not go find the old URL. Record that it is no longer in the folder.

## Docs last seen in the folder

Listed on 2026-10-13. Re-list the folder before using these. They are a checklist, not a frozen set.

- `GuideLLM schedule planning` — schedules tab (link index) and feedback tab: https://docs.google.com/document/d/1e0J2tQvI1PfIEqR6Z_BVYa9cq8gig-_2mDPyEeq4oHo/edit
  - Schedules tab: `?tab=t.m9lywnqc40jf`
  - Feedback tab: `?tab=t.0`
- `GuideLLM release planning`: https://docs.google.com/document/d/1BDW1hJIaYQZ_vCGPzPprqE2Xpq8KvnjmzLCZDKUyKhg/edit
- Work tickets stay on GitHub, not in the folder: https://github.com/vllm-project/guidellm

The feedback tab is titled "Feedback Sept 8 2025". The high-priority section comes first ("Yuchen PM input- and all high priority input"). "Secondary input below" starts the second list. Keep that split. Read `GuideLLM release planning` the same way as the schedules tab: keep dates, capabilities, and links, and follow those links.

Work tickets are GitHub issues. Do not search Jira for the GuideLLM backlog. If feedback mentions a ticket number, look for that number on GitHub before treating it as a Jira key.

## Read a private Google Doc or Sheet

A plain fetch often returns 403. Use a browser session that is already signed in as the user.

- Doc tab as HTML: `https://docs.google.com/document/d/<id>/export?format=html&tab=<tabId>`
- Sheet as xlsx (all tabs): `https://docs.google.com/spreadsheets/d/<id>/export?format=xlsx`
- One sheet tab as csv: `https://docs.google.com/spreadsheets/d/<id>/export?format=csv&gid=<gid>`

Opening the export URL in that browser downloads the file. Read the download. Do not guess page contents from the Google Docs canvas, which often has no text.

If the browser lands on a Google sign-in page, stop and ask the user to log in. Then rerun. Do the same if GitHub returns an auth error: ask them to run `gh auth login`, then rerun. Do not finish the ranking as if a blocked source had been read.

## Links last found inside the schedules doc

After listing the folder, open the live schedules tab and `GuideLLM release planning`, and follow the links that are there now. The last pass of the schedules tab found these. They are a checklist, not a frozen set, and they are not themselves files in the priorities folder:

- vLLM quarterly roadmap: https://github.com/vllm-project/vllm/issues/48168
- RHAIIS release to component version map: https://docs.google.com/spreadsheets/d/17GnTfbYP2nE36VF4LXIBVQeXRGh3fUJmqyNUnSFb9bQ/edit?gid=1141753814#gid=1141753814
- llm-d feature prioritization: https://docs.google.com/spreadsheets/d/1iLxuVKcHz6wnX-1g7vPLxRbBYAFOOqAy2kH3LpYr2_I/edit?usp=sharing
- llm-d KV cache roadmap: https://docs.google.com/document/d/1XgiAiL7CGq70E_bnsll2VJ6g47EpQboN0uH2SOwsGFk/edit?usp=sharing

On the llm-d workbook, read the release tab that matches the current calendar (the 3.6 tab was the live one on 2026-10-13). Use a draft wishlist only to explain a row that is also on the committed release tab.

## Turn a fix version into a date

Feature sheets often say EA2 or GA and do not give a calendar day. Look up that release on the RHAIIS version map and use its code freeze, test, and release dates. Say which sheet supplied the fix version and which sheet supplied the day.

A GuideLLM GitHub milestone that falls after that program date does not win. The program test is the deadline. Write that conflict down.
