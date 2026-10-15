-- Gera CHEATSHEET.md a partir dos atalhos realmente mapeados no Neovim.
-- Não rode à mão: use scripts/gerar-cheatsheet.sh (abre o nvim headless e chama este arquivo).
--
-- Fontes coletadas:
--   1. mapeamentos globais (depois de disparar o User VeryLazy, onde o LazyVim cria os seus)
--   2. mapeamentos de buffer com LSP e gitsigns ativos (abre um arquivo .lua versionado deste repo)
--   3. `keys` com `ft` das specs do lazy.nvim (atalhos por linguagem)
--   4. on_attach de rustaceanvim (atalhos de Rust só existem com o rust-analyzer conectado)
-- Os nomes das seções vêm dos grupos registrados no which-key.

local OUT = assert(vim.env.CHEATSHEET_OUT, "defina CHEATSHEET_OUT")
local SAMPLE = assert(vim.env.CHEATSHEET_SAMPLE, "defina CHEATSHEET_SAMPLE")

local MODES = { n = "Normal", x = "Visual", i = "Insert", t = "Terminal" }
local MODE_ORDER = { "n", "x", "i", "t" }

local FT_NAMES = {
  go = "Go", rust = "Rust", dart = "Flutter / Dart", python = "Python",
  markdown = "Markdown", typescript = "TypeScript", javascript = "JavaScript",
  yaml = "YAML", helm = "Helm", terraform = "Terraform",
}

-- ── helpers ──────────────────────────────────────────────────────────────────
local leader = vim.g.mapleader or "\\"

local function pretty(lhs)
  lhs = vim.fn.keytrans(vim.api.nvim_replace_termcodes(lhs, true, true, true))
  local lt = vim.fn.keytrans(leader)
  if lhs:sub(1, #lt) == lt then lhs = "<leader>" .. lhs:sub(#lt + 1) end
  -- nomes que o keytrans usa mas ninguém digita assim
  lhs = lhs:gsub("^<NL>", "<C-J>"):gsub("<lt>", "<")
  return lhs
end

local function skip(lhs, desc)
  if not desc or desc == "" then return true end
  if desc:find("which%-key%-trigger") or desc:find("^which_key") then return true end
  -- padrões do próprio Neovim (não são configuração) e os pares automáticos do mini.pairs
  if desc:find("^:help ") or desc:find("action for ") or desc:find("^MiniPairs") then return true end
  if lhs:find("<Plug>") or lhs:find("<SNR>") or lhs:find("Mouse>") or lhs:find("^<Scroll") then return true end
  return false
end

local function md_escape(s)
  return (s:gsub("|", "\\|"))
end

-- descrições podem citar teclas (<Tab>) que viram HTML no Markdown
local function md_text(s)
  return (md_escape(s):gsub("<", "\\<"))
end

-- entries[key] = { mode, lhs, desc }; key = mode .. lhs (lhs já em forma "pretty")
local general, by_ft = {}, {}

local function put(tbl, mode, lhs, desc)
  lhs = pretty(lhs)
  if skip(lhs, desc) then return end
  tbl[mode .. "\0" .. lhs] = { mode = mode, lhs = lhs, desc = desc }
end

local function put_ft(ft, mode, lhs, desc)
  by_ft[ft] = by_ft[ft] or {}
  put(by_ft[ft], mode, lhs, desc)
end

-- ── coleta ───────────────────────────────────────────────────────────────────
local function collect()
  -- 1 + 2: globais e do buffer de exemplo (o de buffer vence: é o efetivo com LSP/git)
  for _, mode in ipairs(MODE_ORDER) do
    for _, m in ipairs(vim.api.nvim_get_keymap(mode)) do put(general, mode, m.lhs, m.desc) end
    for _, m in ipairs(vim.api.nvim_buf_get_keymap(0, mode)) do put(general, mode, m.lhs, m.desc) end
  end

  -- 3: keys com ft nas specs do lazy.nvim
  local Plugin = require("lazy.core.plugin")
  for _, p in pairs(require("lazy.core.config").plugins) do
    for _, k in ipairs(Plugin.values(p, "keys", true) or {}) do
      if type(k) == "table" and k.ft and k.desc then
        local fts = type(k.ft) == "table" and k.ft or { k.ft }
        local modes = type(k.mode) == "table" and k.mode or { k.mode or "n" }
        for _, ft in ipairs(fts) do
          for _, mode in ipairs(modes) do
            if MODES[mode] then put_ft(ft, mode, k[1], k.desc) end
          end
        end
        -- o lhs global pode ter vindo deste mesmo buffer: tira das seções gerais
        for _, mode in ipairs(modes) do
          local key = mode .. "\0" .. pretty(k[1])
          if general[key] and general[key].desc == k.desc then general[key] = nil end
        end
      end
    end
  end

  -- 4: on_attach do rustaceanvim aplicado num buffer descartável
  local rust = require("lazy.core.config").plugins["rustaceanvim"]
  if rust then
    local opts = Plugin.values(rust, "opts", false)
    local on_attach = opts and opts.server and opts.server.on_attach
    if on_attach then
      local buf = vim.api.nvim_create_buf(false, true)
      pcall(on_attach, nil, buf)
      for _, mode in ipairs(MODE_ORDER) do
        for _, m in ipairs(vim.api.nvim_buf_get_keymap(buf, mode)) do put_ft("rust", mode, m.lhs, m.desc) end
      end
      vim.api.nvim_buf_delete(buf, { force = true })
    end
  end
end

-- ── grupos (which-key) ───────────────────────────────────────────────────────
local function groups()
  local g = {}
  local ok, cfg = pcall(require, "which-key.config")
  if not ok then return g end
  for _, m in ipairs(cfg.mappings or {}) do
    if m.group and m.lhs then
      -- which-key v3 guarda group = true e o nome em desc (que pode ser função)
      local name = type(m.group) == "string" and m.group or m.desc
      if type(name) == "function" then name = name() end
      if type(name) == "string" and name ~= "" then
        local modes = type(m.mode) == "table" and m.mode or { m.mode or "n" }
        for _, mode in ipairs(modes) do
          if mode == "n" or mode == "v" or mode == "x" then g[pretty(m.lhs)] = name end
        end
      end
    end
  end
  return g
end

-- ── seções ───────────────────────────────────────────────────────────────────
local function section_of(e, grp)
  local lhs = e.lhs
  if lhs:sub(1, 8) == "<leader>" then
    local rest = lhs:sub(9)
    -- prefixo de 1 tecla (ou <Tab>) depois do leader
    local first = rest:match("^(<[^>]+>)") or rest:sub(1, 1)
    if #rest > #first then
      local pfx = "<leader>" .. first
      return "leader:" .. pfx, grp[pfx] or "outros"
    end
    return "leader:<leader>", "atalhos diretos"
  end
  if lhs:match("^[%[%]]") then return "nav", "Pular para anterior / próximo (`[` / `]`)" end
  if lhs:match("^g") or lhs:match("^z") then return "g", "Prefixos `g` e `z`" end
  if lhs:match("^<[CMAS]%-") or lhs:match("^<[cmas]%-") then return "ctrl", "Ctrl / Alt / Shift" end
  if e.first == "x" then return "other-x", "Outras teclas — Visual e objetos de texto" end
  if e.first == "i" or e.first == "t" then return "other-i", "Outras teclas — Insert / Terminal" end
  return "other-n", "Outras teclas — Normal"
end

local function sort_entries(list)
  table.sort(list, function(a, b)
    if a.lhs:lower() ~= b.lhs:lower() then return a.lhs:lower() < b.lhs:lower() end
    return a.lhs < b.lhs
  end)
end

local function table_lines(list, with_mode)
  local lines = {}
  if with_mode then
    lines[#lines + 1] = "| Atalho | Modo | Ação |"
    lines[#lines + 1] = "|---|---|---|"
  else
    lines[#lines + 1] = "| Atalho | Ação |"
    lines[#lines + 1] = "|---|---|"
  end
  for _, e in ipairs(list) do
    -- tecla com crase precisa de delimitador duplo no code span
    local key = e.lhs:find("`") and ("`` " .. md_escape(e.lhs) .. " ``") or ("`" .. md_escape(e.lhs) .. "`")
    if with_mode then
      lines[#lines + 1] = ("| %s | %s | %s |"):format(key, e.modes, md_text(e.desc))
    else
      lines[#lines + 1] = ("| %s | %s |"):format(key, md_text(e.desc))
    end
  end
  return lines
end

-- junta o mesmo lhs+desc em modos diferentes numa linha só ("Normal, Visual")
local function merge_modes(tbl)
  local merged, order = {}, {}
  for _, mode in ipairs(MODE_ORDER) do
    for _, e in pairs(tbl) do
      if e.mode == mode then
        local k = e.lhs .. "\0" .. e.desc
        if not merged[k] then
          merged[k] = { lhs = e.lhs, desc = e.desc, modes = MODES[mode], first = mode }
          order[#order + 1] = merged[k]
        else
          merged[k].modes = merged[k].modes .. ", " .. MODES[mode]
        end
      end
    end
  end
  return order
end

local function render()
  local grp = groups()
  local out = {
    "# Neovim — Sumário de Atalhos",
    "",
    "<!-- Gerado por scripts/gerar-cheatsheet.sh a partir dos mapeamentos reais. Não edite à mão. -->",
    "",
    ("> Gerado em %s · Leader = `%s` · Descrições como registradas pelos plugins/config."):format(
      os.date("%Y-%m-%d"), leader == " " and "<Space>" or leader),
    "> Versão comentada e com dicas: [`SHORTCUTS.md`](./SHORTCUTS.md). PDF: `scripts/cheatsheet-pdf.sh`.",
    "",
  }

  -- seções gerais
  local sections, sec_order = {}, {}
  for _, e in ipairs(merge_modes(general)) do
    local id, title = section_of(e, grp)
    if not sections[id] then
      sections[id] = { title = title, list = {} }
      sec_order[#sec_order + 1] = id
    end
    table.insert(sections[id].list, e)
  end
  local rank = { ["leader:<leader>"] = 0, nav = 2, g = 3, ctrl = 4, ["other-n"] = 5, ["other-x"] = 6, ["other-i"] = 7 }
  table.sort(sec_order, function(a, b)
    local ra = rank[a] or (a:find("^leader:") and 1 or 9)
    local rb = rank[b] or (b:find("^leader:") and 1 or 9)
    if ra ~= rb then return ra < rb end
    return a:lower() < b:lower()
  end)

  -- índice
  out[#out + 1] = "## Índice"
  out[#out + 1] = ""
  -- mesmo slug do GitHub: minúsculas, pontuação ASCII removida (menos "-"), espaço vira "-"
  local function anchor(s)
    s = s:lower():gsub("—", ""):gsub("%p", function(c) return c == "-" and c or "" end)
    return (s:gsub(" ", "-"))
  end
  local headings = {}
  for _, id in ipairs(sec_order) do
    local s = sections[id]
    local h = id:find("^leader:") and id ~= "leader:<leader>"
        and ("`%s` — %s"):format(id:sub(8), s.title)
        or (id == "leader:<leader>" and "`<leader>` — atalhos diretos" or s.title)
    s.heading = h
    headings[#headings + 1] = h
  end
  local fts = vim.tbl_keys(by_ft)
  table.sort(fts, function(a, b) return (FT_NAMES[a] or a) < (FT_NAMES[b] or b) end)
  for _, h in ipairs(headings) do out[#out + 1] = ("- [%s](#%s)"):format(h, anchor(h)) end
  out[#out + 1] = "- [Por linguagem](#por-linguagem)"
  out[#out + 1] = ""

  out[#out + 1] = "## Geral"
  out[#out + 1] = ""
  for _, id in ipairs(sec_order) do
    local s = sections[id]
    sort_entries(s.list)
    out[#out + 1] = "### " .. s.heading
    out[#out + 1] = ""
    vim.list_extend(out, table_lines(s.list, true))
    out[#out + 1] = ""
  end

  out[#out + 1] = "## Por linguagem"
  out[#out + 1] = ""
  out[#out + 1] = "Valem só em buffers do tipo indicado; podem sobrepor o atalho geral de mesma tecla."
  out[#out + 1] = ""
  for _, ft in ipairs(fts) do
    local list = merge_modes(by_ft[ft])
    sort_entries(list)
    out[#out + 1] = ("### %s (`%s`)"):format(FT_NAMES[ft] or ft, ft)
    out[#out + 1] = ""
    vim.list_extend(out, table_lines(list, true))
    out[#out + 1] = ""
  end

  local f = assert(io.open(OUT, "w"))
  f:write(table.concat(out, "\n"))
  f:close()
end

-- ── execução ─────────────────────────────────────────────────────────────────
vim.api.nvim_exec_autocmds("User", { pattern = "VeryLazy" })
vim.cmd.edit(SAMPLE)

-- espera LSP e gitsigns anexarem ao buffer de exemplo (com teto)
local deadline = vim.uv.now() + 30000
local function ready()
  local has_lsp = #vim.lsp.get_clients({ bufnr = 0 }) > 0
  local has_git = vim.b.gitsigns_head ~= nil or vim.b.gitsigns_status_dict ~= nil
  return (has_lsp and has_git) or vim.uv.now() > deadline
end

local function finish()
  local ok, err = pcall(function()
    collect()
    render()
  end)
  if not ok then
    io.stderr:write("cheatsheet: " .. tostring(err) .. "\n")
    vim.cmd("cquit 1")
  end
  vim.cmd("qa!")
end

local timer = vim.uv.new_timer()
timer:start(500, 500, vim.schedule_wrap(function()
  if ready() then
    timer:stop()
    -- dá tempo ao LspAttach do LazyVim criar os keymaps de buffer
    vim.defer_fn(finish, 2000)
  end
end))
