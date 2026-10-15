# Neovim Config

Configuração pessoal baseada em [LazyVim](https://www.lazyvim.org/), com suporte às stacks: Go, Rust, Python, TypeScript/Next.js, Flutter/Dart, Kubernetes/Helm e Terraform.

---

## Pré-requisitos

| Ferramenta | Versão mínima | Para quê |
|---|---|---|
| Neovim | >= 0.11.2 (exigido pelo LazyVim) | — |
| Git, curl, unzip, gcc, make | qualquer | lazy.nvim, Mason e treesitter |
| ripgrep (`rg`) | qualquer | grep do projeto |
| fd | qualquer | busca de arquivos e `venv-selector` |
| Go | a dos seus projetos | Mason compila `gopls`, `goimports`, `gofumpt` e `delve` com `go install` |
| Node.js + npm | LTS | Mason instala via npm `vtsls`, `pyright`, `yaml-language-server`, `prettier`, `markdownlint-cli2`… |
| Python 3 (com `venv`) | qualquer | `debugpy` e ferramentas Python do Mason |
| rustup com toolchain padrão | stable | `rust-analyzer`/`rustfmt`/`clippy` (`rustup default stable`) |
| Flutter | opcional | só para projetos Dart/Flutter |
| lazygit | opcional | `<leader>tg` |
| xclip (X11) ou wl-clipboard (Wayland) | qualquer | clipboard do sistema |
| Nerd Font | qualquer | ícones ([nerdfonts.com](https://www.nerdfonts.com/)) |

> Sem Go ou Node no `PATH` o Mason não consegue instalar boa parte dos LSPs e o Neovim exibe erros como
> `failed to install vtsls` ou `Could not find executable "npm" in PATH`. Veja [Solução de problemas](#solução-de-problemas).

### Instalação dos pré-requisitos

**macOS:**

```bash
brew install neovim git ripgrep fd go node lazygit rustup
rustup default stable
```

**Linux sem sudo** (tudo no diretório do usuário):

```bash
# Go -> ~/.local/go  (troque a versão pela desejada)
curl -LO https://go.dev/dl/go1.27.2.linux-amd64.tar.gz
rm -rf ~/.local/go && tar -C ~/.local -xzf go1.27.2.linux-amd64.tar.gz
echo 'export PATH="$HOME/.local/go/bin:$HOME/go/bin:$PATH"' >> ~/.bashrc

# Node via nvm -> ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash
source ~/.bashrc && nvm install --lts

# fd -> ~/.local/bin (binário oficial; no apt o pacote é fd-find e o comando se chama fdfind)
curl -LO https://github.com/sharkdp/fd/releases/download/v10.5.0/fd-v10.5.0-x86_64-unknown-linux-gnu.tar.gz
tar -xzf fd-v10.5.0-x86_64-unknown-linux-gnu.tar.gz
install -m755 fd-v10.5.0-x86_64-unknown-linux-gnu/fd ~/.local/bin/fd

# Rust
rustup default stable
```

Depois disso abra um **terminal novo** (ou `source ~/.bashrc`) antes de iniciar o Neovim.

---

## Instalação

### 1. Backup da config atual (se existir)

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.local/state/nvim ~/.local/state/nvim.bak 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null
```

### 2. Clonar o repositório

```bash
git clone https://github.com/asolheiro/neovim-configs ~/.config/nvim
```

### 3. Iniciar o Neovim

```bash
nvim
```

Na primeira abertura, o [lazy.nvim](https://github.com/folke/lazy.nvim) faz o bootstrap e instala os plugins nas versões do `lazy-lock.json`. O [Mason](https://github.com/mason-org/mason.nvim) instala em seguida os LSPs, formatters, linters e DAP adapters.

> Aguarde a conclusão de `:Lazy` e `:Mason` antes de editar código.

### 4. Verificar saúde do ambiente

```bash
nvim +checkhealth
```

---

## Estrutura de Arquivos

```text
~/.config/nvim/
├── init.lua                   # Entrypoint — chama config.lazy
├── lazyvim.json               # Estado interno do LazyVim
├── lazy-lock.json             # Lockfile de versões dos plugins
├── SHORTCUTS.md               # Referência comentada de atalhos
├── CHEATSHEET.md              # Sumário de todos os atalhos (gerado — não editar)
├── scripts/
│   ├── gerar-cheatsheet.sh    # Gera CHEATSHEET.md via nvim headless
│   ├── cheatsheet.lua         # Coletor de atalhos usado pelo script acima
│   └── cheatsheet-pdf.sh      # Exporta CHEATSHEET.md para PDF
├── markdownlint/
│   └── .markdownlint.yaml     # Regras base do markdownlint (nvim-lint e conform)
└── lua/
    ├── config/
    │   ├── lazy.lua           # Bootstrap do lazy.nvim + spec de plugins/extras
    │   ├── options.lua        # Opções do editor (números relativos, scrolloff, etc.)
    │   ├── keymaps.lua        # Keymaps customizados
    │   └── autocmds.lua       # Autocomandos (indentação por linguagem, etc.)
    └── plugins/
        ├── editor.lua         # which-key, neo-tree, git-blame, diffview, tmux-navigator…
        ├── lang.lua           # go.nvim, rustaceanvim, flutter-tools, venv-selector, markdown…
        ├── infra.lua          # Kubernetes, Helm, Terraform, YAML schemas, conform, Mason
        ├── terminal.lua       # ToggleTerm com lazygit e Python REPL
        └── ui.lua             # tokyonight, lualine, bufferline, dashboard, colorizer…
```

---

## Linguagens Suportadas

| Linguagem | LSP | Formatter | Linter | DAP | Plugin extra |
|---|---|---|---|---|---|
| Go | `gopls` | `goimports` + `gofumpt` | `golangci-lint` | `delve` | `go.nvim` |
| Rust | `rust-analyzer` (check com `clippy`) | `rustfmt` | — | `codelldb` | `rustaceanvim` |
| Python | `pyright` + `ruff` | `ruff_format` + `ruff_organize_imports` | `ruff` (via LSP) | `debugpy` | `venv-selector` |
| TypeScript / JS | `vtsls` | `prettier` | — | `js-debug-adapter` | `ts-error-translator` |
| Flutter / Dart | `dartls` | `dart_format` | — | `dart-debug-adapter` | `flutter-tools` |
| Markdown | `marksman` | `prettier` + `markdownlint-cli2` | `markdownlint-cli2` | — | `render-markdown` + `markdown-preview` |
| YAML | `yaml-language-server` | `prettier` | — | — | schemas K8s/GHA/Compose |
| TOML | `taplo` | — | — | — | — |
| Docker | `dockerls` + `docker-compose-language-service` | — | `hadolint` | — | filetype detection |
| Helm | `helm-ls` | — | — | — | `vim-helm` |
| Terraform / HCL | — | `terraform_fmt` | — | — | `vim-terraform` |
| Lua | `lua-language-server` | `stylua` | — | — | — |
| Shell | — | `shfmt` | — | — | — |

---

## Features Principais

### Editor

- **fzf-lua** — picker ativo para arquivos, buffers, grep e git (a extra do Telescope também está importada)
- **Snacks explorer** em `<leader>e`; **Neo-tree** disponível via `:Neotree`, com dotfiles visíveis
- **Flash.nvim** — navegação por jump em qualquer ponto da tela (`s` / `S`)
- **mini.surround** — adiciona/remove/troca delimitadores (`gsa`, `gsd`, `gsr`)
- **Yanky** — histórico de yank (`<leader>p`)
- **todo-comments** — destaca `TODO`, `FIXME`, `HACK` com busca integrada
- **nvim-bqf** — quickfix melhorado com preview
- **vim-tmux-navigator** — `Ctrl+h/j/k/l` entre splits do Neovim e panes do tmux

### Git

- **gitsigns** (LazyVim) — hunks inline, stage/reset por hunk (`<leader>gh…`)
- **git-blame** — blame inline com `<leader>gb`
- **diffview** — diff completo e histórico de arquivo (`<leader>gd`, `<leader>gh`)
- **lazygit** via ToggleTerm (`<leader>tg`)

### LSP & Código

- **nvim-lspconfig** gerenciado pelo LazyVim
- **conform.nvim** — formatação ao salvar, por linguagem (liga/desliga com `<leader>uf`)
- **nvim-lint** — linters por linguagem
- **blink.cmp** (LazyVim default) — autocompletar
- **treesitter** com treesitter-context (breadcrumb do escopo atual)
- **Mason** — instalação automática de LSPs, formatters, linters e DAP

### Markdown

- Regras base em `markdownlint/.markdownlint.yaml`: tamanho de linha (`MD013`) e estilo de tabela (`MD060`)
  desligados. Um `.markdownlint*` do próprio projeto continua tendo precedência.
- `<leader>mf` corrige os avisos com `markdownlint-cli2 --fix`
- `<leader>md` esconde/mostra os diagnósticos do buffer (leitura sem ruído); `<leader>ud` faz o mesmo globalmente
- `<leader>mp` renderiza no buffer, `<leader>mb` abre preview no browser

### Debug (DAP)

- **nvim-dap** + **nvim-dap-ui** — UI completa de debug
- Suporte a Go (delve), Python (debugpy), Rust (codelldb), JS/TS (js-debug-adapter), Flutter

### UI

- **Tema:** TokyoNight Night
- **Statusline:** lualine com nome do LSP ativo
- **Bufferline:** abas com diagnósticos
- **Dashboard** customizado
- **indent-blankline** — guias de indentação
- **neoscroll** — scroll suave
- **nvim-colorizer** — preview de cores hex/CSS/Tailwind

### Infra / Cloud

- **k8s.nvim** — lista pods/namespaces, descreve recursos (`<leader>k`)
- **YAML schemas** automáticos para Kubernetes, GitHub Actions, Docker Compose
- **vim-helm** + **helm-ls** — templates Helm com LSP
- **vim-terraform** — fmt on save para `.tf` / `.hcl`

---

## Atalhos Rápidos

> Referência comentada em [`SHORTCUTS.md`](./SHORTCUTS.md). Sumário completo, gerado dos mapeamentos reais,
> em [`CHEATSHEET.md`](./CHEATSHEET.md):
>
> ```bash
> scripts/gerar-cheatsheet.sh          # regenera CHEATSHEET.md (lê os atalhos do próprio nvim)
> scripts/cheatsheet-pdf.sh --gerar    # regenera e exporta CHEATSHEET.pdf (requer npm + Chrome/Chromium)
> ```

| Atalho | Ação |
|---|---|
| `<Space>ff` | Busca arquivo |
| `<Space>/` | Live grep no projeto |
| `<Space>e` | File explorer |
| `Ctrl+\` | Toggle terminal |
| `<Space>tg` | LazyGit |
| `gd` | Vai à definição |
| `<Space>ca` | Code actions |
| `<Space>cr` | Renomeia símbolo |
| `<Space>cf` | Formata arquivo |
| `s` | Flash jump |
| `<Space>db` | Toggle breakpoint |
| `<Space>dc` | Continuar debug |

---

## Solução de problemas

| Sintoma | Causa / solução |
|---|---|
| `failed to install <pacote>` / `Could not find executable "npm"` (ou `"go"`) | Node/Go ausente no `PATH` do processo do Neovim. Instale-os e abra o `nvim` em um terminal que já carregou o `~/.bashrc`; depois `:Mason` reinstala o que faltou. Detalhes em `:MasonLog`. |
| `Package is already installing` no config do mason.nvim | Pacote repetido em `ensure_installed`. O `infra.lua` deduplica a lista final — mantenha essa função ao adicionar ferramentas. |
| `Cannot find package "chrome-debug-adapter"` | `dap.core` importado depois das extras de linguagem em `lazy.lua`; ele precisa vir antes. |
| `rustup could not choose a version of rustc` | Nenhum toolchain padrão: `rustup default stable`. |
| `Cannot find any fd binary` | `fd` ausente (no Ubuntu o pacote `fd-find` instala `fdfind`; crie o link `~/.local/bin/fd`). |
| `Flutter executable could not be found` | Flutter não instalado; só aparece ao abrir `.dart`. |
| Muitos avisos do markdownlint | Ajuste `markdownlint/.markdownlint.yaml` (`MDxxx: false`) ou use `<leader>md` / `<leader>mf`. |

---

## Manter Sincronizado

Após alterar os arquivos de configuração em `~/.config/nvim`, commite e faça push para manter o repositório atualizado:

```bash
cd ~/.config/nvim
git add -A
git commit -m "feat: <descrição>"
git push
```

Para atualizar plugins (commite o `lazy-lock.json` resultante):

```bash
nvim +"Lazy update"
```
