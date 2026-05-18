# Neovim Config

Configuração pessoal baseada em [LazyVim](https://www.lazyvim.org/), com suporte às stacks: Go, Rust, Python, TypeScript/Next.js, Flutter/Dart, Kubernetes/Helm e Terraform.

---

## Pré-requisitos

| Ferramenta | Versão mínima | Instalação |
|---|---|---|
| Neovim | >= 0.10 | `brew install neovim` |
| Git | qualquer | `brew install git` |
| Node.js | >= 18 | `brew install node` |
| ripgrep | qualquer | `brew install ripgrep` |
| fd | qualquer | `brew install fd` |
| Nerd Font | qualquer | [nerdfonts.com](https://www.nerdfonts.com/) |
| lazygit | qualquer | `brew install lazygit` |

> **Linux (Ubuntu/Debian):** substitua `brew` por `apt` ou `snap install nvim --classic` para Neovim.

---

## Instalação

### 1. Backup da config atual (se existir)

```bash
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null
mv ~/.cache/nvim ~/.cache/nvim.bak 2>/dev/null
```

### 2. Clonar o repositório

```bash
git clone https://github.com/<seu-usuario>/neovim-configs ~/.config/nvim
```

### 3. Iniciar o Neovim

```bash
nvim
```

Na primeira abertura, o [lazy.nvim](https://github.com/folke/lazy.nvim) faz o bootstrap automaticamente e instala todos os plugins. O [Mason](https://github.com/williamboman/mason.nvim) instalará os LSPs, formatters e DAP adapters na sequência.

> Aguarde a conclusão de `:Lazy` e `:Mason` antes de editar código.

### 4. Verificar saúde do ambiente

```bash
nvim +checkhealth
```

---

## Estrutura de Arquivos

```
~/.config/nvim/
├── init.lua                   # Entrypoint — chama config.lazy
├── lazyvim.json               # Estado interno do LazyVim (extras habilitados)
├── lazy-lock.json             # Lockfile de versões dos plugins
├── SHORTCUTS.md               # Referência completa de atalhos
└── lua/
    ├── config/
    │   ├── lazy.lua           # Bootstrap do lazy.nvim + spec de plugins/extras
    │   ├── options.lua        # Opções do editor (números relativos, scrolloff, etc.)
    │   ├── keymaps.lua        # Keymaps customizados
    │   └── autocmds.lua       # Autocomandos (indentação por linguagem, etc.)
    └── plugins/
        ├── editor.lua         # Editor geral: which-key, neo-tree, git-blame, diffview…
        ├── lang.lua           # Plugins de linguagem: go.nvim, rustaceanvim, flutter-tools…
        ├── infra.lua          # Infra: Kubernetes, Helm, Terraform, YAML schemas, Mason…
        ├── terminal.lua       # ToggleTerm com lazygit e Python REPL
        └── ui.lua             # UI: tokyonight, lualine, bufferline, colorizer…
```

---

## Linguagens Suportadas

| Linguagem | LSP | Formatter | DAP | Plugin extra |
|---|---|---|---|---|
| Go | `gopls` | `goimports` + `gofumpt` | `delve` | `go.nvim` |
| Rust | `rust-analyzer` | `rustfmt` | `codelldb` | `rustaceanvim` |
| Python | `pyright` + `ruff` | `ruff_format` | `debugpy` | `venv-selector` |
| TypeScript / JS | `ts_ls` | `prettier` | — | `ts-error-translator` |
| Flutter / Dart | `dart` LSP | `dart_format` | `dart-debug-adapter` | `flutter-tools` |
| Markdown | `marksman` | `prettier` | — | `render-markdown` + `markdown-preview` |
| YAML | `yaml-ls` | `prettier` | — | schemas K8s/GHA/Compose |
| TOML | `taplo` | — | — | — |
| Docker | `dockerls` | — | — | filetype detection |
| Helm | `helm-ls` | — | — | `vim-helm` |
| Terraform / HCL | — | `terraform_fmt` | — | `vim-terraform` |
| Lua | `lua-ls` | `stylua` | — | — |
| Shell | — | `shfmt` | — | — |

---

## Features Principais

### Editor
- **Telescope + fzf-native** — fuzzy search em arquivos, buffers, grep, git commits
- **Neo-tree** — file explorer com dotfiles visíveis
- **Flash.nvim** — navegação por jump em qualquer ponto da tela (`s` / `S`)
- **mini.surround** — adiciona/remove/troca delimitadores (`gsa`, `gsd`, `gsr`)
- **Yanky** — histórico de yank (`<leader>p`)
- **todo-comments** — destaca `TODO`, `FIXME`, `HACK` com busca integrada
- **nvim-bqf** — quickfix melhorado com preview
- **nvim-autopairs** — fecha pares automaticamente com contexto treesitter

### Git
- **gitsigns** (LazyVim) — hunks inline, stage/reset por hunk
- **git-blame** — blame inline com `<leader>gb`
- **diffview** — diff completo e histórico de arquivo (`<leader>gd`, `<leader>gh`)
- **lazygit** via ToggleTerm (`<leader>tg`)

### LSP & Código
- **nvim-lspconfig** gerenciado pelo LazyVim
- **conform.nvim** — formatação no save (por linguagem)
- **nvim-cmp** + **LuaSnip** (LazyVim defaults)
- **treesitter** com treesitter-context (breadcrumb do escopo atual)
- **Mason** — instalação automática de LSPs, formatters e DAP

### Debug (DAP)
- **nvim-dap** + **nvim-dap-ui** — UI completa de debug
- Suporte a Go (delve), Python (debugpy), Rust (codelldb), Flutter

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

> Referência completa em [`SHORTCUTS.md`](./SHORTCUTS.md).

| Atalho | Ação |
|---|---|
| `<Space>ff` | Busca arquivo |
| `<Space>fg` | Live grep no projeto |
| `<Space>e` | File explorer |
| `Ctrl+\` | Toggle terminal |
| `<Space>tg` | LazyGit |
| `gd` | Vai à definição |
| `<Space>ca` | Code actions |
| `<Space>cr` | Renomeia símbolo |
| `s` | Flash jump |
| `<Space>db` | Toggle breakpoint |
| `<Space>dc` | Continuar debug |

---

## Manter Sincronizado

Após alterar os arquivos de configuração em `~/.config/nvim`, commite e faça push para manter o repositório atualizado:

```bash
cd ~/.config/nvim
git add -A
git commit -m "feat: <descrição>"
git push
```

Para atualizar plugins:

```bash
nvim +Lazy update
```
