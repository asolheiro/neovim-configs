#!/usr/bin/env bash
# Gera CHEATSHEET.md com todos os atalhos configurados, lidos do próprio Neovim.
#
# Uso: scripts/gerar-cheatsheet.sh [saida.md]   (padrão: CHEATSHEET.md na raiz do repo)
#
# Precisa dos plugins instalados (:Lazy) e de um LSP para Lua (lua-language-server via Mason),
# porque os atalhos de LSP/git só existem em buffers com LSP e gitsigns anexados.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
out="$(realpath -m "${1:-$repo/CHEATSHEET.md}")"

# buffer de exemplo: arquivo Lua versionado → anexa lua_ls (atalhos LSP) e gitsigns (atalhos de hunk)
sample="$repo/lua/config/keymaps.lua"

# roda a partir do repo para o LazyVim achar a raiz do projeto
cd "$repo"
CHEATSHEET_OUT="$out" CHEATSHEET_SAMPLE="$sample" \
  timeout 120 nvim --headless -c "luafile $repo/scripts/cheatsheet.lua" </dev/null

if [[ ! -s "$out" ]]; then
  echo "erro: $out não foi gerado" >&2
  exit 1
fi
echo "gerado: $out ($(grep -c '^| `' "$out") atalhos)"
