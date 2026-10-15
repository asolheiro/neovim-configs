# Neovim — Sumário de Atalhos

<!-- Gerado por scripts/gerar-cheatsheet.sh a partir dos mapeamentos reais. Não edite à mão. -->

> Gerado em 2026-10-15 · Leader = `<Space>` · Descrições como registradas pelos plugins/config.
> Versão comentada e com dicas: [`SHORTCUTS.md`](./SHORTCUTS.md). PDF: `scripts/cheatsheet-pdf.sh`.

## Índice

- [`<leader>` — atalhos diretos](#leader--atalhos-diretos)
- [`<leader><Tab>` — tabs](#leadertab--tabs)
- [`<leader>b` — buffer](#leaderb--buffer)
- [`<leader>c` — code](#leaderc--code)
- [`<leader>d` — debug](#leaderd--debug)
- [`<leader>f` — file/find](#leaderf--filefind)
- [`<leader>g` — git](#leaderg--git)
- [`<leader>k` — kubernetes](#leaderk--kubernetes)
- [`<leader>m` — markdown](#leaderm--markdown)
- [`<leader>q` — quit/session](#leaderq--quitsession)
- [`<leader>s` — search/split](#leaders--searchsplit)
- [`<leader>t` — terminal](#leadert--terminal)
- [`<leader>u` — ui](#leaderu--ui)
- [`<leader>v` — vim config](#leaderv--vim-config)
- [`<leader>w` — windows](#leaderw--windows)
- [`<leader>x` — diagnostics/quickfix](#leaderx--diagnosticsquickfix)
- [Pular para anterior / próximo (`[` / `]`)](#pular-para-anterior--próximo---)
- [Prefixos `g` e `z`](#prefixos-g-e-z)
- [Ctrl / Alt / Shift](#ctrl--alt--shift)
- [Outras teclas — Normal](#outras-teclas--normal)
- [Outras teclas — Visual e objetos de texto](#outras-teclas--visual-e-objetos-de-texto)
- [Outras teclas — Insert / Terminal](#outras-teclas--insert--terminal)
- [Por linguagem](#por-linguagem)

## Geral

### `<leader>` — atalhos diretos

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>,` | Normal | Switch Buffer |
| `<leader>-` | Normal | Split Window Below |
| `<leader>.` | Normal | Toggle Scratch Buffer |
| `<leader>/` | Normal | Grep (Root Dir) |
| `<leader>:` | Normal | Command History |
| `<leader><Space>` | Normal | Find Files (Root Dir) |
| `<leader>?` | Normal | Buffer Keymaps (which-key) |
| `` <leader>` `` | Normal | Switch to Other Buffer |
| `<leader>E` | Normal | Explorer Snacks (cwd) |
| `<leader>e` | Normal | Explorer Snacks (root dir) |
| `<leader>K` | Normal | Keywordprg |
| `<leader>L` | Normal | LazyVim Changelog |
| `<leader>l` | Normal | Lazy |
| `<leader>n` | Normal | Notification History |
| `<leader>p` | Normal, Visual | Open Yank History |
| `<leader>S` | Normal | Select Scratch Buffer |
| `<leader>\|` | Normal | Split Window Right |

### `<leader><Tab>` — tabs

| Atalho | Modo | Ação |
|---|---|---|
| `<leader><Tab><Tab>` | Normal | New Tab |
| `<leader><Tab>[` | Normal | Previous Tab |
| `<leader><Tab>]` | Normal | Next Tab |
| `<leader><Tab>d` | Normal | Close Tab |
| `<leader><Tab>f` | Normal | First Tab |
| `<leader><Tab>l` | Normal | Last Tab |
| `<leader><Tab>o` | Normal | Close Other Tabs |

### `<leader>b` — buffer

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>bb` | Normal | Switch to Other Buffer |
| `<leader>bD` | Normal | Delete all other buffers |
| `<leader>bd` | Normal | Delete buffer |
| `<leader>bj` | Normal | Pick Buffer |
| `<leader>bl` | Normal | Delete Buffers to the Left |
| `<leader>bo` | Normal | Delete Other Buffers |
| `<leader>bP` | Normal | Delete Non-Pinned Buffers |
| `<leader>bp` | Normal | Toggle Pin |
| `<leader>br` | Normal | Delete Buffers to the Right |

### `<leader>c` — code

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>cA` | Normal | Source Action |
| `<leader>ca` | Normal, Visual | Code Action |
| `<leader>cC` | Normal | Refresh & Display Codelens |
| `<leader>cc` | Normal, Visual | Run Codelens |
| `<leader>cd` | Normal | Line Diagnostics |
| `<leader>cF` | Normal, Visual | Format Injected Langs |
| `<leader>cf` | Normal, Visual | Format |
| `<leader>cl` | Normal | Lsp Info |
| `<leader>cm` | Normal | Mason |
| `<leader>co` | Normal | Open quickfix |
| `<leader>cR` | Normal | Rename File |
| `<leader>cr` | Normal | Rename |
| `<leader>cS` | Normal | LSP references/definitions/... (Trouble) |
| `<leader>cs` | Normal | Symbols (Trouble) |

### `<leader>d` — debug

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>da` | Normal | Run with Args |
| `<leader>dB` | Normal | Breakpoint Condition |
| `<leader>db` | Normal | Toggle Breakpoint |
| `<leader>dC` | Normal | Run to Cursor |
| `<leader>dc` | Normal | Run/Continue |
| `<leader>de` | Normal, Visual | Eval |
| `<leader>dg` | Normal | Go to Line (No Execute) |
| `<leader>di` | Normal | Step Into |
| `<leader>dj` | Normal | Down |
| `<leader>dk` | Normal | Up |
| `<leader>dl` | Normal | Run Last |
| `<leader>dO` | Normal | Step Over |
| `<leader>do` | Normal | Step Out |
| `<leader>dP` | Normal | Pause |
| `<leader>dph` | Normal | Toggle Profiler Highlights |
| `<leader>dpp` | Normal | Toggle Profiler |
| `<leader>dps` | Normal | Profiler Scratch Buffer |
| `<leader>dr` | Normal | Toggle REPL |
| `<leader>ds` | Normal | Session |
| `<leader>dt` | Normal | Terminate |
| `<leader>du` | Normal | Dap UI |
| `<leader>dw` | Normal | Widgets |

### `<leader>f` — file/find

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>fB` | Normal | Buffers (all) |
| `<leader>fb` | Normal | Buffers |
| `<leader>fc` | Normal | Find Config File |
| `<leader>fE` | Normal | Explorer Snacks (cwd) |
| `<leader>fe` | Normal | Explorer Snacks (root dir) |
| `<leader>fF` | Normal | Find Files (cwd) |
| `<leader>ff` | Normal | Find Files (Root Dir) |
| `<leader>fg` | Normal | Find Files (git-files) |
| `<leader>fn` | Normal | New File |
| `<leader>fR` | Normal | Recent (cwd) |
| `<leader>fr` | Normal | Recent |
| `<leader>fT` | Normal | Terminal (cwd) |
| `<leader>ft` | Normal | Terminal (Root Dir) |

### `<leader>g` — git

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>gB` | Normal, Visual | Git Browse (open) |
| `<leader>gb` | Normal | Toggle git blame |
| `<leader>gc` | Normal | Commits |
| `<leader>gD` | Normal | Diff view close |
| `<leader>gd` | Normal | Diff view open |
| `<leader>gf` | Normal | Git Current File History |
| `<leader>gh` | Normal | File history |
| `<leader>ghB` | Normal | Blame Buffer |
| `<leader>ghb` | Normal | Blame Line |
| `<leader>ghD` | Normal | Diff This ~ |
| `<leader>ghd` | Normal | Diff This |
| `<leader>ghp` | Normal | Preview Hunk Inline |
| `<leader>ghR` | Normal | Reset Buffer |
| `<leader>ghr` | Normal, Visual | Reset Hunk |
| `<leader>ghS` | Normal | Stage Buffer |
| `<leader>ghs` | Normal, Visual | Stage Hunk |
| `<leader>ghu` | Normal | Undo Stage Hunk |
| `<leader>gL` | Normal | Git Log (cwd) |
| `<leader>gl` | Normal | Commits |
| `<leader>gS` | Normal | Git Stash |
| `<leader>gs` | Normal | Status |
| `<leader>gY` | Normal, Visual | Git Browse (copy) |

### `<leader>k` — kubernetes

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>kd` | Normal | K8s describe pod |
| `<leader>kn` | Normal | K8s namespaces |
| `<leader>kp` | Normal | K8s list pods |

### `<leader>m` — markdown

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>mb` | Normal | Preview in browser |
| `<leader>md` | Normal | Toggle diagnostics (buffer) |
| `<leader>mp` | Normal | Toggle markdown render |

### `<leader>q` — quit/session

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>qd` | Normal | Don't Save Current Session |
| `<leader>ql` | Normal | Restore Last Session |
| `<leader>qq` | Normal | Quit All |
| `<leader>qS` | Normal | Select Session |
| `<leader>qs` | Normal | Restore Session |

### `<leader>s` — search/split

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>s"` | Normal | Registers |
| `<leader>s/` | Normal | Search History |
| `<leader>sa` | Normal | Auto Commands |
| `<leader>sb` | Normal | Buffer Lines |
| `<leader>sC` | Normal | Commands |
| `<leader>sc` | Normal | Command History |
| `<leader>sD` | Normal | Buffer Diagnostics |
| `<leader>sd` | Normal | Diagnostics |
| `<leader>se` | Normal | Equalize splits |
| `<leader>sG` | Normal | Grep (cwd) |
| `<leader>sg` | Normal | Grep (Root Dir) |
| `<leader>sH` | Normal | Search Highlight Groups |
| `<leader>sh` | Normal | Split horizontal |
| `<leader>sj` | Normal | Jumplist |
| `<leader>sk` | Normal | Key Maps |
| `<leader>sl` | Normal | Location List |
| `<leader>sM` | Normal | Man Pages |
| `<leader>sm` | Normal | Jump to Mark |
| `<leader>sn` | Normal | +noice |
| `<leader>sna` | Normal | Noice All |
| `<leader>snd` | Normal | Dismiss All |
| `<leader>snh` | Normal | Noice History |
| `<leader>snl` | Normal | Noice Last Message |
| `<leader>snt` | Normal | Noice Picker (Telescope/FzfLua) |
| `<leader>sq` | Normal | Quickfix List |
| `<leader>sR` | Normal | Resume |
| `<leader>sr` | Normal, Visual | Search and Replace |
| `<leader>sS` | Normal | Goto Symbol (Workspace) |
| `<leader>ss` | Normal | Goto Symbol |
| `<leader>sT` | Normal | Todo/Fix/Fixme |
| `<leader>st` | Normal | Todo |
| `<leader>sv` | Normal | Split vertical |
| `<leader>sW` | Normal | Word (cwd) |
| `<leader>sW` | Visual | Selection (cwd) |
| `<leader>sw` | Normal | Word (Root Dir) |
| `<leader>sw` | Visual | Selection (Root Dir) |
| `<leader>sx` | Normal | Close split |

### `<leader>t` — terminal

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>tf` | Normal | Float terminal |
| `<leader>tg` | Normal | Lazygit |
| `<leader>th` | Normal | Horizontal terminal |
| `<leader>tv` | Normal | Vertical terminal |

### `<leader>u` — ui

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>uA` | Normal | Toggle Tabline |
| `<leader>ua` | Normal | Toggle Animations |
| `<leader>ub` | Normal | Toggle Dark Background |
| `<leader>uC` | Normal | Colorscheme with Preview |
| `<leader>uc` | Normal | Toggle Conceal Level |
| `<leader>uD` | Normal | Toggle Dimming |
| `<leader>ud` | Normal | Toggle Diagnostics |
| `<leader>uF` | Normal | Toggle Auto Format (Buffer) |
| `<leader>uf` | Normal | Toggle Auto Format (Global) |
| `<leader>uG` | Normal | Toggle Git Signs |
| `<leader>ug` | Normal | Toggle Indent Guides |
| `<leader>uh` | Normal | Toggle Inlay Hints |
| `<leader>uI` | Normal | Inspect Tree |
| `<leader>ui` | Normal | Inspect Pos |
| `<leader>uL` | Normal | Toggle Relative Number |
| `<leader>ul` | Normal | Toggle Line Numbers |
| `<leader>un` | Normal | Dismiss All Notifications |
| `<leader>up` | Normal | Toggle Mini Pairs |
| `<leader>ur` | Normal | Redraw / Clear hlsearch / Diff Update |
| `<leader>uS` | Normal | Toggle Smooth Scroll |
| `<leader>us` | Normal | Toggle Spelling |
| `<leader>uT` | Normal | Toggle Treesitter Highlight |
| `<leader>ut` | Normal | Toggle Treesitter Context |
| `<leader>uw` | Normal | Toggle Wrap |
| `<leader>uZ` | Normal | Toggle Zoom Mode |
| `<leader>uz` | Normal | Toggle Zen Mode |

### `<leader>v` — vim config

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>vc` | Normal | Edit init.lua |
| `<leader>vl` | Normal | Edit lazy.lua |

### `<leader>w` — windows

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>wd` | Normal | Delete Window |
| `<leader>wm` | Normal | Toggle Zoom Mode |

### `<leader>x` — diagnostics/quickfix

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>xL` | Normal | Location List (Trouble) |
| `<leader>xl` | Normal | Location List |
| `<leader>xQ` | Normal | Quickfix List (Trouble) |
| `<leader>xq` | Normal | Quickfix List |
| `<leader>xT` | Normal | Todo/Fix/Fixme (Trouble) |
| `<leader>xt` | Normal | Todo (Trouble) |
| `<leader>xX` | Normal | Buffer Diagnostics (Trouble) |
| `<leader>xx` | Normal | Diagnostics (Trouble) |

### Pular para anterior / próximo (`[` / `]`)

| Atalho | Modo | Ação |
|---|---|---|
| `[<C-L>` | Normal | :lpfile |
| `[<C-Q>` | Normal | :cpfile |
| `[<C-T>` | Normal | :ptprevious |
| `[<Space>` | Normal | Add empty line above cursor |
| `[[` | Normal | Prev Reference |
| `[A` | Normal, Visual | Prev Parameter End |
| `[a` | Normal, Visual | Prev Parameter Start |
| `[B` | Normal | Move buffer prev |
| `[b` | Normal | Prev Buffer |
| `[C` | Normal, Visual | Prev Class End |
| `[c` | Normal, Visual | Prev Class Start |
| `[D` | Normal | Jump to the first diagnostic in the current buffer |
| `[d` | Normal | Prev Diagnostic |
| `[e` | Normal | Prev Error |
| `[F` | Normal, Visual | Prev Function End |
| `[f` | Normal, Visual | Prev Function Start |
| `[H` | Normal | First Hunk |
| `[h` | Normal | Prev Hunk |
| `[L` | Normal | :lrewind |
| `[l` | Normal | :lprevious |
| `[N` | Visual | Select previous sibling node |
| `[n` | Visual | Select previous node |
| `[P` | Normal | Put Indented Before Cursor (Linewise) |
| `[p` | Normal | Put Indented Before Cursor (Linewise) |
| `[Q` | Normal | :crewind |
| `[q` | Normal | Prev quickfix |
| `[T` | Normal | :trewind |
| `[t` | Normal | Previous Todo Comment |
| `[w` | Normal | Prev Warning |
| `[y` | Normal | Cycle Forward Through Yank History |
| `]<C-L>` | Normal | :lnfile |
| `]<C-Q>` | Normal | :cnfile |
| `]<C-T>` | Normal | :ptnext |
| `]<Space>` | Normal | Add empty line below cursor |
| `]]` | Normal | Next Reference |
| `]A` | Normal, Visual | Next Parameter End |
| `]a` | Normal, Visual | Next Parameter Start |
| `]B` | Normal | Move buffer next |
| `]b` | Normal | Next Buffer |
| `]C` | Normal, Visual | Next Class End |
| `]c` | Normal, Visual | Next Class Start |
| `]D` | Normal | Jump to the last diagnostic in the current buffer |
| `]d` | Normal | Next Diagnostic |
| `]e` | Normal | Next Error |
| `]F` | Normal, Visual | Next Function End |
| `]f` | Normal, Visual | Next Function Start |
| `]H` | Normal | Last Hunk |
| `]h` | Normal | Next Hunk |
| `]L` | Normal | :llast |
| `]l` | Normal | :lnext |
| `]N` | Visual | Select next sibling node |
| `]n` | Visual | Select next node |
| `]P` | Normal | Put Indented After Cursor (Linewise) |
| `]p` | Normal | Put Indented After Cursor (Linewise) |
| `]Q` | Normal | :clast |
| `]q` | Normal | Next quickfix |
| `]T` | Normal | :tlast |
| `]t` | Normal | Next Todo Comment |
| `]w` | Normal | Next Warning |
| `]y` | Normal | Cycle Backward Through Yank History |

### Prefixos `g` e `z`

| Atalho | Modo | Ação |
|---|---|---|
| `g[` | Normal, Visual | Move to left "around" |
| `g]` | Normal, Visual | Move to right "around" |
| `gc` | Normal, Visual | Toggle comment |
| `gcc` | Normal | Toggle comment line |
| `gcO` | Normal | Add Comment Above |
| `gco` | Normal | Add Comment Below |
| `gD` | Normal | Goto Declaration |
| `gd` | Normal | Goto Definition |
| `gI` | Normal | Goto Implementation |
| `gK` | Normal | Signature Help |
| `gO` | Normal | vim.lsp.buf.document_symbol() |
| `gP` | Normal, Visual | Put Text Before Selection |
| `gp` | Normal, Visual | Put Text After Selection |
| `gr` | Normal | References |
| `gra` | Normal, Visual | vim.lsp.buf.code_action() |
| `gri` | Normal | vim.lsp.buf.implementation() |
| `grn` | Normal | vim.lsp.buf.rename() |
| `grr` | Normal | vim.lsp.buf.references() |
| `grt` | Normal | vim.lsp.buf.type_definition() |
| `grx` | Normal | vim.lsp.codelens.run() |
| `gsa` | Normal, Visual | Add Surrounding |
| `gsd` | Normal | Delete Surrounding |
| `gsF` | Normal | Find Left Surrounding |
| `gsf` | Normal | Find Right Surrounding |
| `gsh` | Normal | Highlight Surrounding |
| `gsn` | Normal | Update `MiniSurround.config.n_lines` |
| `gsr` | Normal | Replace Surrounding |
| `gx` | Normal, Visual | Opens filepath or URI under cursor with the system handler (file explorer, web browser, …) |
| `gy` | Normal | Goto T[y]pe Definition |

### Ctrl / Alt / Shift

| Atalho | Modo | Ação |
|---|---|---|
| `<C-/>` | Normal, Terminal | Terminal (Root Dir) |
| `<C-\>` | Normal | Toggle terminal |
| `<C-B>` | Insert | Scroll Backward |
| `<C-Down>` | Normal | Decrease Window Height |
| `<C-F>` | Insert | Scroll Forward |
| `<C-H>` | Normal | Go to left window / tmux pane |
| `<C-J>` | Normal | Go to lower window / tmux pane |
| `<C-K>` | Insert | Signature Help |
| `<C-K>` | Normal | Go to upper window / tmux pane |
| `<C-L>` | Normal | Go to right window / tmux pane |
| `<C-Left>` | Normal | Decrease Window Width |
| `<C-Right>` | Normal | Increase Window Width |
| `<C-S>` | Normal, Visual, Insert | Save File |
| `<C-Space>` | Normal, Visual | Treesitter Incremental Selection |
| `<C-Up>` | Normal | Increase Window Height |
| `<C-W><C-D>` | Normal | Show diagnostics under the cursor |
| `<C-W><Space>` | Normal | Window Hydra Mode (which-key) |
| `<C-W>d` | Normal | Show diagnostics under the cursor |
| `<M-j>` | Normal | Move line down |
| `<M-j>` | Insert | Move Down |
| `<M-j>` | Visual | Move selection down |
| `<M-k>` | Insert | Move Up |
| `<M-k>` | Normal | Move line up |
| `<M-k>` | Visual | Move selection up |
| `<M-n>` | Normal | Next Reference |
| `<M-p>` | Normal | Prev Reference |
| `<S-Tab>` | Insert | vim.snippet.jump if active, otherwise \<S-Tab> |

### Outras teclas — Normal

| Atalho | Modo | Ação |
|---|---|---|
| `<Down>` | Normal, Visual | Down |
| `<Esc>` | Normal, Insert | Escape and Clear hlsearch |
| `<P` | Normal | Put Before and Indent Left |
| `<p` | Normal | Put and Indent Left |
| `<Up>` | Normal, Visual | Up |
| `=P` | Normal | Put Before Applying a Filter |
| `=p` | Normal | Put After Applying a Filter |
| `>P` | Normal | Put Before and Indent Right |
| `>p` | Normal | Put and Indent Right |
| `\r` | Normal, Visual | Run Lua |
| `H` | Normal | Prev Buffer |
| `j` | Normal, Visual | Down |
| `K` | Normal | Hover |
| `k` | Normal, Visual | Up |
| `L` | Normal | Next Buffer |
| `N` | Normal | Prev search result (centered) |
| `n` | Normal | Next search result (centered) |
| `P` | Normal, Visual | Put Text Before Cursor |
| `p` | Normal, Visual | Put Text After Cursor |
| `S` | Normal, Visual | Flash Treesitter |
| `s` | Normal, Visual | Flash |
| `y` | Normal, Visual | Yank Text |

### Outras teclas — Visual e objetos de texto

| Atalho | Modo | Ação |
|---|---|---|
| `<` | Visual | Indent left (keep selection) |
| `>` | Visual | Indent right (keep selection) |
| `a` | Visual | Around textobject |
| `al` | Visual | Around last textobject |
| `an` | Visual | Around next textobject |
| `i` | Visual | Inside textobject |
| `ih` | Visual | GitSigns Select Hunk |
| `il` | Visual | Inside last textobject |
| `in` | Visual | Inside next textobject |
| `N` | Visual | Prev Search Result |
| `n` | Visual | Next Search Result |
| `R` | Visual | Treesitter Search |

### Outras teclas — Insert / Terminal

| Atalho | Modo | Ação |
|---|---|---|
| `<Tab>` | Insert | vim.snippet.jump if active, otherwise \<Tab> |
| `jk` | Insert | Exit insert mode |
| `kj` | Insert | Exit insert mode |

## Por linguagem

Valem só em buffers do tipo indicado; podem sobrepor o atalho geral de mesma tecla.

### Flutter / Dart (`dart`)

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>rd` | Normal | Flutter devices |
| `<leader>re` | Normal | Flutter emulators |
| `<leader>rl` | Normal | Flutter log |
| `<leader>rR` | Normal | Flutter restart |
| `<leader>rr` | Normal | Flutter run |
| `<leader>rs` | Normal | Flutter stop |

### Go (`go`)

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>ra` | Normal | Go add struct tags |
| `<leader>rc` | Normal | Go coverage |
| `<leader>re` | Normal | Go if err |
| `<leader>ri` | Normal | Go imports |
| `<leader>rr` | Normal | Go run |
| `<leader>rT` | Normal | Go test func under cursor |
| `<leader>rt` | Normal | Go test |

### Markdown (`markdown`)

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>cp` | Normal | Markdown Preview |
| `<leader>mf` | Normal | Fix markdownlint issues |

### Python (`python`)

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>cv` | Normal | Select VirtualEnv |
| `<leader>dPc` | Normal | Debug Class |
| `<leader>dPt` | Normal | Debug Method |
| `<leader>rc` | Normal | Select cached venv |
| `<leader>rv` | Normal | Select virtualenv |
| `<leader>tp` | Normal | Python REPL |

### Rust (`rust`)

| Atalho | Modo | Ação |
|---|---|---|
| `<leader>rc` | Normal | Open Cargo.toml |
| `<leader>rd` | Normal | Debuggables |
| `<leader>re` | Normal | Expand macro |
| `<leader>rr` | Normal | Runnables |
| `<leader>rt` | Normal | Testables |
