---
name: korean-markdown-to-pdf
description: Export Markdown documents to PDF with bundled Korean fonts and word wrapping. Use when the user asks to convert or export Markdown as PDF.
---

# Export Markdown to PDF

## 1. Scope

Export only the Markdown files the user names. Confirm that each named source exists, then run the build script once per file. Derive the PDF path from the source name unless the user gives an output path.

Done when every requested source has a matching PDF path, no unrequested file is selected, and generated PDFs stay out of version control unless the user asks otherwise.

Read the applicable `AGENTS.md` and project instructions before export. Do not add generated PDFs to public output unless the user requests it. Done when the export follows project instructions and no PDF enters public output without an explicit request.

## 2. Source Integrity

Keep the source Markdown unchanged. Preserve facts, dates, numbers, names, technical terms, and existing links. Add new links only when the user asks.

Done when the source file is unchanged and every existing link is preserved.

## 3. Build

Run the build script from the repository root. In this repository, the script is `skills/korean-markdown-to-pdf/scripts/build_pdf.sh`. When the skill is installed elsewhere, use the `scripts/build_pdf.sh` file in the installed skill directory.

```bash
bash skills/korean-markdown-to-pdf/scripts/build_pdf.sh <input.md> <output.pdf>
```

The script uses the bundled stylesheet and Korean word filter when Pandoc and WeasyPrint are available. It reports the build path it selects. Done when it reports a path and the output PDF exists.

## 4. Inspect

Open the generated PDF and inspect every page.

- Confirm visible text, links, and page numbers. Look for clipped text, unexpected blank pages, and broken Korean words.
- If the script reports the Pandoc-only fallback, expect different styling and no Korean word filter. Check Korean words closely.
- Compare the PDF text with the source Markdown. Confirm that names, dates, numbers, technical terms, and other facts match.

Done when every page is inspected, parity is confirmed, and any issue that needs a source change is reported without editing the source.
