#!/usr/bin/env bash
# Convert an HTML report to a Google Doc in the competition Drive folder.
# Usage: publish_gdoc.sh <html-file> [document-title]
set -euo pipefail

if ! command -v gws >/dev/null 2>&1; then
  echo "gws is required (Google Workspace CLI). Install from https://github.com/googleworkspace/cli" >&2
  exit 1
fi

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <html-file> [document-title]" >&2
  exit 1
fi

HTML="$(python3 -c 'import os,sys; print(os.path.abspath(sys.argv[1]))' "$1")"
if [[ ! -f "${HTML}" ]]; then
  echo "HTML file not found: ${HTML}" >&2
  exit 1
fi

TITLE="${2:-GuideLLM functionality compare}"
FOLDER_ID="${GUIDELLM_COMPETITION_DRIVE_FOLDER:-1cTkqKcKgetyJL2CSIoLD4RTFDTjIMywX}"
HTML_DIR="$(dirname "${HTML}")"
HTML_BASE="$(basename "${HTML}")"

PAYLOAD="$(python3 -c 'import json,sys; print(json.dumps({"name": sys.argv[1], "mimeType": "application/vnd.google-apps.document", "parents": [sys.argv[2]]}))' "${TITLE}" "${FOLDER_ID}")"

echo "Uploading '${TITLE}' to Drive folder ${FOLDER_ID}..." >&2

RESPONSE="$(
  cd "${HTML_DIR}"
  gws drive files create \
    --params '{"supportsAllDrives": true}' \
    --json "${PAYLOAD}" \
    --upload "${HTML_BASE}" \
    --upload-content-type "text/html"
)"

python3 -c '
import json, sys
d = json.loads(sys.argv[1])
file_id = d.get("id", "")
link = d.get("webViewLink") or (f"https://docs.google.com/document/d/{file_id}/edit" if file_id else "")
print(json.dumps({"id": file_id, "name": d.get("name"), "webViewLink": link}, indent=2))
if not file_id:
    sys.exit(1)
' "${RESPONSE}"
