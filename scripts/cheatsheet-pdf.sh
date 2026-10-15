#!/usr/bin/env bash
# Converte CHEATSHEET.md em PDF (A4, duas colunas) usando marked (npm) + Chrome/Chromium headless.
#
# Uso: scripts/cheatsheet-pdf.sh [--gerar] [entrada.md] [saida.pdf]
#   --gerar   regenera o CHEATSHEET.md antes (scripts/gerar-cheatsheet.sh)
#   padrões:  CHEATSHEET.md → CHEATSHEET.pdf na raiz do repo
#
# Requer: node/npm e google-chrome, chromium ou chromium-browser no PATH
#         (ou CHROME=/caminho/do/binario).
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MARKED_VERSION="18.1.1"

if [[ "${1:-}" == "--gerar" ]]; then
  shift
  "$repo/scripts/gerar-cheatsheet.sh"
fi

in="$(realpath "${1:-$repo/CHEATSHEET.md}")"
out="$(realpath -m "${2:-${in%.md}.pdf}")"

chrome="${CHROME:-}"
if [[ -z "$chrome" ]]; then
  for c in google-chrome google-chrome-stable chromium chromium-browser; do
    if command -v "$c" >/dev/null 2>&1; then chrome="$c"; break; fi
  done
fi
[[ -n "$chrome" ]] || { echo "erro: Chrome/Chromium não encontrado (defina CHROME=...)" >&2; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "erro: npm não encontrado" >&2; exit 1; }

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

npm install --prefix "$tmp" --no-save --silent "marked@$MARKED_VERSION" >/dev/null

cat >"$tmp/build.js" <<'EOF'
const fs = require("fs");
const { Marked } = require(process.env.MARKED_PATH);
const [, , input, output] = process.argv;

// mesmo slug do GitHub (e do índice gerado em scripts/cheatsheet.lua)
const slug = (text) =>
  text.toLowerCase().replace(/—/g, "").replace(/[!-,./:-@[-^`{-~]/g, "").replace(/ /g, "-");

const marked = new Marked({
  gfm: true,
  renderer: {
    heading({ tokens, depth, text }) {
      const html = this.parser.parseInline(tokens);
      return `<h${depth} id="${slug(text)}">${html}</h${depth}>\n`;
    },
  },
});

const css = `
@page { size: A4; margin: 10mm 9mm; }
:root { --fg: #1f2328; --muted: #59636e; --line: #d1d9e0; --accent: #0969da; --code-bg: #eff2f5; }
* { box-sizing: border-box; }
body { font: 7.6pt/1.3 "Inter", "Segoe UI", "Helvetica Neue", Arial, sans-serif; color: var(--fg); margin: 0; }
h1 { font-size: 15pt; margin: 0 0 2mm; }
h2 { font-size: 10.5pt; margin: 3mm 0 1.5mm; padding-bottom: 0.8mm; border-bottom: 1.5px solid var(--accent);
     column-span: all; color: var(--accent); }
h3 { font-size: 8.6pt; margin: 2.2mm 0 0.8mm; break-after: avoid; }
blockquote { margin: 0 0 2mm; padding: 1mm 2.5mm; border-left: 2px solid var(--line); color: var(--muted); }
blockquote p { margin: 0.3mm 0; }
a { color: var(--accent); text-decoration: none; }
code { font: 7.2pt/1.2 "JetBrains Mono", "DejaVu Sans Mono", monospace; background: var(--code-bg);
       padding: 0 0.6mm; border-radius: 2px; white-space: nowrap; }
.content { column-count: 2; column-gap: 6mm; }
table { width: 100%; border-collapse: collapse; margin-bottom: 1mm; }
th { text-align: left; font-weight: 600; color: var(--muted); border-bottom: 1px solid var(--line); padding: 0.4mm 1mm; }
td { border-bottom: 0.5px solid #eef1f4; padding: 0.35mm 1mm; vertical-align: top; }
td:first-child { width: 28%; }
td:nth-child(2) { width: 17%; color: var(--muted); white-space: nowrap; }
tr { break-inside: avoid; }
ul { margin: 0; padding-left: 4mm; columns: 3; }
li { margin: 0; }
`;

const md = fs.readFileSync(input, "utf8").replace(/<!--[\s\S]*?-->/g, "");
// título e cabeçalho ocupam a largura toda; o resto vai para as duas colunas
const body = marked.parse(md).replace(/(<h2 id="geral">)/, '<div class="content">$1') + "</div>";

fs.writeFileSync(
  output,
  `<!doctype html><html lang="pt-BR"><head><meta charset="utf-8"><title>Neovim — Atalhos</title>
<style>${css}</style></head><body>${body}</body></html>`,
);
EOF

MARKED_PATH="$tmp/node_modules/marked" node "$tmp/build.js" "$in" "$tmp/cheatsheet.html"

"$chrome" --headless=new --disable-gpu --no-sandbox --no-pdf-header-footer \
  --user-data-dir="$tmp/chrome" --print-to-pdf="$out" "file://$tmp/cheatsheet.html" >/dev/null 2>&1

[[ -s "$out" ]] || { echo "erro: PDF não gerado" >&2; exit 1; }
echo "gerado: $out"
