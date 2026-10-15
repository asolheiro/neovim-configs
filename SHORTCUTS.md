# Neovim Shortcuts — Guia de Referência

> **Leader** = `<Space>`   |   Modo: N = Normal, I = Insert, V = Visual, T = Terminal
>
> Lista completa e sempre atualizada (gerada dos mapeamentos reais): [`CHEATSHEET.md`](./CHEATSHEET.md).

---

## Fundamentos do Vim (base para tudo)

```text
┌──────────────────────────────────────────────────────────────────────┐
│  MOVIMENTO                                                           │
│                                                                      │
│   h j k l   ←↓↑→ por caractere      w / b   próx/ant palavra        │
│   W / B     próx/ant WORD            e / ge  fim de palavra          │
│   0 / ^     início de linha          $        fim de linha            │
│   gg / G    início / fim do arquivo  {  }     parágrafos             │
│   %         pula para par ({[        *        busca palavra sob cursor│
│   f<c> F<c> vai até char na linha    t<c>     antes do char          │
│   Ctrl+d    desce meia tela (centrado)         Ctrl+u  sobe meia tela│
│   zz        centraliza cursor                                        │
└──────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────┐
│  EDIÇÃO                                                              │
│                                                                      │
│   i / I     insert cursor / início da linha                         │
│   a / A     append cursor / fim da linha                            │
│   o / O     nova linha abaixo / acima                               │
│   s / S     substitui char / linha                                  │
│   c<motion> change (ex: ciw = muda palavra)                         │
│   d<motion> delete (ex: dd = linha, dw = palavra)                   │
│   y<motion> yank/copy (ex: yy = linha, yiw = palavra)               │
│   p / P     cola abaixo / acima                                     │
│   u         desfaz           Ctrl+r  refaz                           │
│   .         repete último comando                                    │
│   ~         troca maiúsc/minúsc                                      │
│   gu / gU   minúsculo / maiúsculo (com motion)                      │
│                                                                      │
│  OBJETOS DE TEXTO (usados com c/d/y/v):                             │
│   iw / aw   palavra (sem/com espaço)                                │
│   i" / a"   dentro/ao redor de aspas                                │
│   i( / a(   dentro/ao redor de parênteses                           │
│   ip / ap   parágrafo                                               │
│   it / at   tag HTML                                                │
└──────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────┐
│  VISUAL                                                              │
│                                                                      │
│   v         Visual por caractere                                     │
│   V         Visual por linha                                         │
│   Ctrl+v    Visual em bloco (coluna)                                │
│   < / >     indentar (mantém seleção)                               │
│   Alt+j/k   move bloco selecionado ↓/↑                              │
└──────────────────────────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────────────────────────┐
│  BUSCA & SUBSTITUIÇÃO                                                │
│                                                                      │
│   /texto    busca para frente     ?texto  busca para trás           │
│   n / N     próximo / anterior                                      │
│   :s/old/new/g    substitui na linha                                │
│   :%s/old/new/g   substitui no arquivo                              │
│   :%s/old/new/gc  substitui com confirmação                         │
└──────────────────────────────────────────────────────────────────────┘
```

---

## Escape & Insert

| Atalho   | Ação                    |
|----------|-------------------------|
| `jk`     | Sai do Insert mode (N)  |
| `kj`     | Idem                    |
| `Ctrl+w` | Apaga palavra (Insert)  |

---

## Arquivos & Buffers

| Atalho          | Ação                         |
|-----------------|------------------------------|
| `<leader>ff`    | Busca arquivo (fzf-lua)      |
| `<leader>fr`    | Arquivos recentes            |
| `<leader>fg`    | Busca arquivos versionados (git files) |
| `<leader>/` / `<leader>sg` | Live grep no projeto |
| `<leader>fb`    | Busca nos buffers abertos    |
| `<leader>e`     | Abre/fecha a árvore de arquivos (Snacks; abre sozinha ao iniciar) |
| `<leader>E`     | Árvore a partir do diretório atual (cwd) |
| `:Neotree`      | File explorer alternativo (Neo-tree, sem atalho) |
| `Shift+l`       | Próximo buffer               |
| `Shift+h`       | Buffer anterior              |
| `<leader>bd`    | Fecha buffer atual           |
| `<leader>bD`    | Fecha todos os outros        |
| `Ctrl+s`        | Salva arquivo                |
| `<leader>qq`    | Sai do Neovim (fecha tudo)   |
| `<leader>qs` / `<leader>ql` | Restaura sessão (diretório / última) |

---

## Janelas & Splits

| Atalho          | Ação                         |
|-----------------|------------------------------|
| `<leader>sv`    | Split vertical               |
| `<leader>sh`    | Split horizontal             |
| `<leader>se`    | Equaliza splits              |
| `<leader>sx`    | Fecha split                  |
| `Ctrl+h/j/k/l`  | Navega entre splits          |
| `Ctrl+←→↑↓`     | Redimensiona split           |

---

## LSP — Code Intelligence

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `gd`            | Vai à definição                   |
| `gD`            | Vai à declaração                  |
| `gr`            | Referências                       |
| `gI`            | Vai à implementação               |
| `K`             | Hover (documentação)              |
| `gK`            | Signature help                    |
| `<leader>cr`    | Renomeia símbolo                  |
| `<leader>ca`    | Code actions                      |
| `<leader>cf`    | Formata arquivo                   |
| `<leader>cd`    | Diagnóstico da linha              |
| `<leader>xx`    | Lista todos os diagnósticos (Trouble) |
| `[d` / `]d`     | Diagnóstico anterior / próximo    |
| `<leader>ss`    | Símbolos do documento             |
| `<leader>sS`    | Símbolos do workspace             |
| `<leader>cs`    | Símbolos (painel Trouble)         |
| `<leader>uf`    | Liga/desliga formatação ao salvar |

---

## Git

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>tg`    | LazyGit (terminal flutuante)      |
| `<leader>gd`    | DiffView (diff completo)          |
| `<leader>gh`    | Histórico do arquivo              |
| `<leader>gb`    | Toggle git blame inline           |
| `<leader>gs`    | Git status (fzf-lua)              |
| `<leader>gc`    | Git commits (fzf-lua)             |
| `]h` / `[h`     | Próxima / anterior hunk           |
| `<leader>ghp`   | Preview da hunk                   |
| `<leader>ghr`   | Reset hunk                        |
| `<leader>ghs`   | Stage hunk                        |

> `<leader>gh` sozinho abre o histórico do arquivo (diffview) e também é o prefixo dos atalhos de hunk:
> ao digitar `<leader>gh` o Neovim espera o `timeoutlen` antes de abrir o histórico.

---

## Terminal

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `Ctrl+\`        | Toggle terminal (float)           |
| `<leader>tf`    | Terminal flutuante                |
| `<leader>th`    | Terminal horizontal               |
| `<leader>tv`    | Terminal vertical                 |
| `<leader>tg`    | LazyGit                           |
| `<leader>tp`    | Python REPL (em .py)              |

---

## Debug (DAP)

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>db`    | Toggle breakpoint                 |
| `<leader>dB`    | Breakpoint condicional            |
| `<leader>dc`    | Continuar                         |
| `<leader>di`    | Step into                         |
| `<leader>dO`    | Step over                         |
| `<leader>do`    | Step out                          |
| `<leader>dr`    | REPL do debugger                  |
| `<leader>du`    | Toggle DAP UI                     |

---

## Linguagens — Atalhos Específicos

### Go (`<leader>r` em arquivos .go)

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>rr`    | go run                            |
| `<leader>rt`    | go test                           |
| `<leader>rT`    | Testa função sob cursor           |
| `<leader>ri`    | go imports                        |
| `<leader>rc`    | go coverage                       |
| `<leader>ra`    | Adiciona struct tags              |
| `<leader>re`    | Gera if err                       |

### Rust (`<leader>r` em arquivos .rs)

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>rr`    | Runnables                         |
| `<leader>rt`    | Testables                         |
| `<leader>rd`    | Debuggables                       |
| `<leader>re`    | Expand macro                      |
| `<leader>rc`    | Abre Cargo.toml                   |

### Flutter (`<leader>r` em arquivos .dart)

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>rr`    | flutter run                       |
| `<leader>rR`    | flutter restart (hot reload)      |
| `<leader>rs`    | flutter stop                      |
| `<leader>rd`    | Listar devices                    |
| `<leader>re`    | Emuladores                        |
| `<leader>rl`    | Toggle logs                       |

### Python (`<leader>r` em arquivos .py)

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>rv`    | Selecionar virtualenv             |
| `<leader>tp`    | Abrir Python REPL                 |

### Markdown (`<leader>m`)

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>mp`    | Toggle render in-buffer           |
| `<leader>mb`    | Preview no browser                |
| `<leader>mf`    | Corrigir avisos do markdownlint   |
| `<leader>md`    | Liga/desliga diagnostics no buffer |
| `<leader>ud`    | Liga/desliga diagnostics (global) |

> Regras do markdownlint: `markdownlint/.markdownlint.yaml` (tamanho de linha desligado).

---

## Kubernetes & Infra

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>kp`    | Listar pods                       |
| `<leader>kn`    | Namespaces                        |
| `<leader>kd`    | Descrever pod                     |

---

## Quickfix & Locallist

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>co`    | Abre quickfix                     |
| `<leader>cc`    | Fecha quickfix (em buffers com LSP vira "Run Codelens") |
| `]q` / `[q`     | Próximo / anterior item           |

---

## Navegação Avançada (Flash.nvim)

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `s`             | Flash jump (chars na tela)        |
| `S`             | Flash treesitter (seleciona nó)   |
| `r`             | Flash remote (operator pending)   |
| `R`             | Flash treesitter search           |

---

## Config Rápida

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>vc`    | Editar init.lua                   |
| `<leader>vl`    | Editar lazy.lua                   |
| `:Lazy`         | Gerenciar plugins                 |
| `:LazyExtras`   | Habilitar extras do LazyVim       |
| `:Mason`        | Gerenciar LSPs/formatters/DAP     |
| `:checkhealth`  | Verificar saúde do ambiente       |

---

## Dicas Cross-Platform

```text
macOS:   Cmd+C/V funcionam no terminal (clipboard via pbcopy)
Linux:   xclip ou xsel precisa estar instalado (apt install xclip)
         O clipboard "unnamedplus" usa o X11 clipboard (+)
WSL:     Config especial de clipboard já incluída no options.lua
```

> Abra este arquivo com `:e ~/.config/nvim/SHORTCUTS.md` e use `:RenderMarkdown toggle` para ver formatado.
