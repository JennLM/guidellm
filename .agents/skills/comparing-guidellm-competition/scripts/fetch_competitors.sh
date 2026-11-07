#!/usr/bin/env bash
# Export the canonical competitor Google Doc as plain text.
# Usage: fetch_competitors.sh [output-path]
set -euo pipefail

FILE_ID="${GUIDELLM_COMPETITORS_DOC_ID:-1Pi7HDi-sny-NNfkGOjK2D_sPnM9kXJwP7YKPdbIRKUI}"
OUT="${1:-/dev/stdout}"

if ! command -v gws >/dev/null 2>&1; then
  echo "gws is required to refresh the competitor list. Using references/competitors.md instead." >&2
  exit 2
fi

if [[ "${OUT}" == "/dev/stdout" ]]; then
  gws drive files export --params "{\"fileId\":\"${FILE_ID}\",\"mimeType\":\"text/plain\"}" --output /dev/stdout
else
  gws drive files export --params "{\"fileId\":\"${FILE_ID}\",\"mimeType\":\"text/plain\"}" --output "${OUT}"
  echo "Wrote ${OUT}" >&2
fi
