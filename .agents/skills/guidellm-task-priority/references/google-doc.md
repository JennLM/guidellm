# Google Doc output

The markdown file is the repo copy. The document the user reads is a Google Doc with the same sections as [output-template.md](output-template.md).

## Build the Word file

Write `planning/guidellm/YYYY-MM-DD-task-priority.docx` next to the markdown. Use `python-docx` if it is installed. If it is not, install it into the workspace virtualenv, or into a temporary virtualenv, and then write the file.

Use a real Word heading for the title and for each section (Decision, Now, Next, Later, Gaps, Parked issues, Conflicts, Sources). Put each ranking table in a Word table with a header row, not as a pasted markdown table. Keep issue numbers as plain text with the GitHub URL, for example `#1082`.

## Upload it as a Google Doc

Save every new priority file in this Drive folder, not in My Drive root:

https://drive.google.com/drive/folders/1C5F69QCEC7LqDR7Kh4U6RmJBmssTxvV-?usp=drive_link

Use the browser session that is already signed in as the user.

1. Open that folder URL.
2. Choose New, then File upload, and upload the `.docx`. Uploading from inside the folder is what places the file there.
3. Open the uploaded file with Google Docs so Drive converts it. The address should be a `docs.google.com/document/d/` URL. If conversion creates a second file, leave the Google Doc in this folder and do not also leave a copy in My Drive root.
4. Copy that URL into the top of the markdown file and into the chat reply.

If Drive shows a Google sign-in page, ask the user to log in and upload again after they do. Leave the `.docx` in place either way.
