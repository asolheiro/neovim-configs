# Neovim Shortcuts — Guia de Referência

> **Leader** = `<Space>`   |   Modo: N = Normal, I = Insert, V = Visual, T = Terminal

---

## Fundamentos do Vim (base para tudo)

```
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
| `Ctrl+h` | Apaga palavra (Insert)  |

---

## Arquivos & Buffers

| Atalho          | Ação                         |
|-----------------|------------------------------|
| `<leader>ff`    | Busca arquivo (Telescope)    |
| `<leader>fr`    | Arquivos recentes            |
| `<leader>fg`    | Live grep no projeto         |
| `<leader>fb`    | Busca nos buffers abertos    |
| `<leader>e`     | Abre file explorer (Neo-tree)|
| `Shift+l`       | Próximo buffer               |
| `Shift+h`       | Buffer anterior              |
| `<leader>bd`    | Fecha buffer atual           |
| `<leader>bD`    | Fecha todos os outros        |
| `<leader>w`     | Salva arquivo                |
| `<leader>q`     | Fecha janela                 |
| `<leader>Q`     | Fecha tudo (força)           |

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
| `gi`            | Vai à implementação               |
| `gK`            | Hover (documentação)              |
| `<leader>cr`    | Renomeia símbolo                  |
| `<leader>ca`    | Code actions                      |
| `<leader>lf`    | Formata arquivo                   |
| `<leader>ld`    | Diagnóstico da linha              |
| `<leader>lD`    | Lista todos os diagnósticos       |
| `[d` / `]d`     | Diagnóstico anterior / próximo    |
| `<leader>cs`    | Symbols (documento)               |
| `<leader>cS`    | Symbols (workspace)               |

---

## Git

| Atalho          | Ação                              |
|-----------------|-----------------------------------|
| `<leader>tg`    | LazyGit (terminal flutuante)      |
| `<leader>gd`    | DiffView (diff completo)          |
| `<leader>gh`    | Histórico do arquivo              |
| `<leader>gb`    | Toggle git blame inline           |
| `<leader>gs`    | Git status (Telescope)            |
| `<leader>gc`    | Git commits (Telescope)           |
| `]h` / `[h`     | Próxima / anterior hunk           |
| `<leader>gp`    | Preview da hunk                   |
| `<leader>gr`    | Reset hunk                        |
| `<leader>gS`    | Stage hunk                        |

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
| `<leader>do`    | Step over                         |
| `<leader>dO`    | Step out                          |
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
| `<leader>cc`    | Fecha quickfix                    |
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

```
macOS:   Cmd+C/V funcionam no terminal (clipboard via pbcopy)
Linux:   xclip ou xsel precisa estar instalado (apt install xclip)
         O clipboard "unnamedplus" usa o X11 clipboard (+)
WSL:     Config especial de clipboard já incluída no options.lua
```

> Abra este arquivo com `:e ~/.config/nvim/SHORTCUTS.md` e use `:RenderMarkdown toggle` para ver formatado.
