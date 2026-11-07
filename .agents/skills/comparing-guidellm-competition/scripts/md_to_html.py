#!/usr/bin/env python3
"""Convert a comparison markdown report to simple HTML for Google Docs upload."""

from __future__ import annotations

import html
import re
import sys
from pathlib import Path


def inline(text: str) -> str:
    text = html.escape(text)

    def link(match: re.Match[str]) -> str:
        label, url = match.group(1), match.group(2)
        return f'<a href="{html.escape(url, quote=True)}">{label}</a>'

    text = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", link, text)
    text = re.sub(r"`([^`]+)`", r"<code>\1</code>", text)
    text = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", text)
    return text


def convert(md: str) -> str:
    lines = md.splitlines()
    out: list[str] = [
        "<html><body>",
    ]
    i = 0
    while i < len(lines):
        line = lines[i]
        if not line.strip():
            i += 1
            continue
        if line.startswith("# "):
            out.append(f"<h1>{inline(line[2:])}</h1>")
        elif line.startswith("## "):
            out.append(f"<h2>{inline(line[3:])}</h2>")
        elif line.startswith("### "):
            out.append(f"<h3>{inline(line[4:])}</h3>")
        elif line.startswith("|"):
            rows: list[str] = []
            while i < len(lines) and lines[i].startswith("|"):
                rows.append(lines[i])
                i += 1
            out.extend(table_html(rows))
            continue
        elif line.startswith("- "):
            out.append("<ul>")
            while i < len(lines) and lines[i].startswith("- "):
                out.append(f"<li>{inline(lines[i][2:])}</li>")
                i += 1
            out.append("</ul>")
            continue
        else:
            out.append(f"<p>{inline(line)}</p>")
        i += 1
    out.append("</body></html>")
    return "\n".join(out) + "\n"


def table_html(rows: list[str]) -> list[str]:
    parsed = []
    for row in rows:
        cells = [c.strip() for c in row.strip().strip("|").split("|")]
        parsed.append(cells)
    if len(parsed) >= 2 and all(re.fullmatch(r":?-{3,}:?", c.replace(" ", "")) for c in parsed[1]):
        header, body = parsed[0], parsed[2:]
    else:
        header, body = parsed[0], parsed[1:]
    html_rows = ["<table>", "<thead><tr>"]
    html_rows.extend(f"<th>{inline(c)}</th>" for c in header)
    html_rows.append("</tr></thead><tbody>")
    for row in body:
        html_rows.append("<tr>")
        html_rows.extend(f"<td>{inline(c)}</td>" for c in row)
        html_rows.append("</tr>")
    html_rows.append("</tbody></table>")
    return html_rows


def main() -> int:
    if len(sys.argv) != 3:
        print("Usage: md_to_html.py <input.md> <output.html>", file=sys.stderr)
        return 2
    src = Path(sys.argv[1])
    dst = Path(sys.argv[2])
    dst.write_text(convert(src.read_text(encoding="utf-8")), encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
