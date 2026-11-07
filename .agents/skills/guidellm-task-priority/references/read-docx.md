# Read a .docx

Word files are zip archives. Paragraph text lives in `word/document.xml`. Run this with the file path so heading order is preserved (the high-priority list must stay above the secondary list).

```bash
python3 - "$DOCX_PATH" <<'PY'
import sys
import zipfile
from xml.etree import ElementTree as ET

path = sys.argv[1]
ns = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
with zipfile.ZipFile(path) as zf:
    root = ET.fromstring(zf.read("word/document.xml"))
for para in root.iter(ns + "p"):
    text = "".join((node.text or "") for node in para.iter(ns + "t")).strip()
    if text:
        print(text)
PY
```

Treat the printed lines as the document, in order. Do not reorder them before you identify the two feedback lists.
