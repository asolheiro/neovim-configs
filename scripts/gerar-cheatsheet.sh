#!/usr/bin/env bash
# Gera CHEATSHEET.md com todos os atalhos configurados, lidos do próprio Neovim.
#
# Uso: scripts/gerar-cheatsheet.sh [saida.md]   (padrão: CHEATSHEET.md na raiz do repo)
#
# Precisa dos plugins instalados (:Lazy) e de um LSP para Lua (lua-language-server via Mason),
# porque os atalhos de LSP/git só existem em buffers com LSP e gitsigns anexados.
set -euo pipefail

repo="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
# caminho absoluto sem `realpath -m` (só existe no GNU coreutils, não no macOS)
out="${1:-$repo/CHEATSHEET.md}"
[[ "$out" == /* ]] || out="$PWD/$out"

# buffer de exemplo: arquivo Lua versionado → anexa lua_ls (atalhos LSP) e gitsigns (atalhos de hunk)
sample="$repo/lua/config/keymaps.lua"

# roda a partir do repo para o LazyVim achar a raiz do projeto
cd "$repo"
# limite de 120s sem `timeout` (GNU coreutils): um vigia em segundo plano mata o nvim se travar
CHEATSHEET_OUT="$out" CHEATSHEET_SAMPLE="$sample" \
  nvim --headless -c "luafile $repo/scripts/cheatsheet.lua" </dev/null &
nvim_pid=$!
( sleep 120 && kill "$nvim_pid" 2>/dev/null ) &
watchdog_pid=$!
status=0
wait "$nvim_pid" || status=$?
kill "$watchdog_pid" 2>/dev/null || true
wait "$watchdog_pid" 2>/dev/null || true
if [[ $status -ne 0 ]]; then
  echo "erro: nvim saiu com código $status (143 = passou de 120s)" >&2
  exit 1
fi

if [[ ! -s "$out" ]]; then
  echo "erro: $out não foi gerado" >&2
  exit 1
fi
echo "gerado: $out ($(grep -c '^| `' "$out") atalhos)"
