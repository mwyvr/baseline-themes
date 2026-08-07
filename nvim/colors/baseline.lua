-- baseline — dual-mode Neovim colorscheme, sibling of the Helix themes.
-- Reads 'background'; :set background=light|dark reapplies live.
-- Core coverage only: editor UI, treesitter captures, diagnostics, diff,
-- spell, and the built-in terminal. Plugin highlight groups are out of
-- scope by design; most fall back sensibly onto these groups.
--
-- Philosophy (see the repo README): highlight what is scarce, mute what is
-- everywhere. Constants and strings green, functions blue, parameters
-- orange, escapes cyan, macros magenta; keywords, operators, variables,
-- and types stay at the default foreground; punctuation recedes.

local dark = {
  bg = "#111418", fg = "#C3C7CF", strong = "#E1E2E8",
  sf_low = "#191C20", sf = "#1D2024", sf_high = "#272A2F", sf_top = "#32353A",
  outline = "#8D9199", outline_var = "#43474E",
  comment = "#77777A", doc = "#909094", linenr = "#5E5E61", faint = "#5E5E61",
  ws = "#32353A", -- whitespace/indent hints: surfaceContainerHighest
  primary = "#A0CAFD", primary_c = "#194975", on_primary_c = "#D1E4FF",
  secondary_c = "#3B4858", on_secondary_c = "#D7E3F7",
  tertiary_c = "#523F5F", on_tertiary_c = "#F2DAFF",
  inverse = "#E1E2E8", on_inverse = "#2E3135",
  green = "#A1D39A", blue = "#AAC7FF", orange = "#FDB975", cyan = "#83D3E3",
  magenta = "#EBB5ED", yellow = "#D4C871", red = "#FFB3AC",
  green_c = "#235024", red_c = "#73332F", yellow_c = "#4F4800",
  change_bg = "#191C20",
  term = {
    "#32353A", "#FFB3AC", "#A1D39A", "#D4C871", "#AAC7FF", "#EBB5ED",
    "#83D3E3", "#C3C7CF", "#8D9199", "#FFDAD6", "#BDF0B5", "#F1E48A",
    "#D6E3FF", "#FFD6FE", "#A0EFFF", "#E1E2E8",
  },
}

local light = {
  bg = "#F8F9FF", fg = "#42474E", strong = "#191C20",
  sf_low = "#F2F3F9", sf = "#EDEDF4", sf_high = "#E7E8EE", sf_top = "#E1E2E8",
  outline = "#73777F", outline_var = "#C3C7CF",
  comment = "#77777A", doc = "#5E5E61", linenr = "#919093", faint = "#919093",
  ws = "#C3C7CF", -- whitespace/indent hints: outlineVariant
  primary = "#35618E", primary_c = "#D1E4FF", on_primary_c = "#001D36",
  secondary_c = "#D7E3F8", on_secondary_c = "#101C2B",
  tertiary_c = "#F2DAFF", on_tertiary_c = "#251531",
  inverse = "#2E3035", on_inverse = "#EFF0F6",
  green = "#3C683A", blue = "#415F90", orange = "#865318", cyan = "#006876",
  magenta = "#7B4E7F", yellow = "#685F12", red = "#BA1A1A",
  green_c = "#BDF0B5", red_c = "#FFDAD6", yellow_c = "#F1E48A",
  change_bg = "#F2F3F9",
  term = {
    "#191C20", "#BA1A1A", "#3C683A", "#685F12", "#415F90", "#7B4E7F",
    "#006876", "#E1E2E8", "#73777F", "#93000A", "#245024", "#4F4800",
    "#284777", "#613766", "#004E59", "#FFFFFF",
  },
}

local p = vim.o.background == "light" and light or dark

vim.cmd.highlight("clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd.syntax("reset")
end
vim.g.colors_name = "baseline"

local groups = {
  -- UI ------------------------------------------------------------------
  Normal = { fg = p.fg, bg = p.bg },
  NormalNC = { fg = p.fg, bg = p.bg },
  NormalFloat = { fg = p.strong, bg = p.sf_high },
  FloatBorder = { fg = p.outline_var, bg = p.sf_high },
  FloatTitle = { fg = p.strong, bg = p.sf_high, bold = true },
  Cursor = { reverse = true },
  TermCursor = { reverse = true },
  CursorLine = { bg = p.sf },
  CursorColumn = { bg = p.sf },
  ColorColumn = { bg = p.sf_low },
  CursorLineNr = { fg = p.primary, bold = true },
  LineNr = { fg = p.linenr },
  SignColumn = { fg = p.outline, bg = p.bg },
  WinSeparator = { fg = p.outline_var },
  VertSplit = { fg = p.outline_var },
  StatusLine = { fg = p.strong, bg = p.sf },
  StatusLineNC = { fg = p.outline, bg = p.sf_low },
  WinBar = { fg = p.strong, bold = true },
  WinBarNC = { fg = p.outline },
  TabLine = { fg = p.outline, bg = p.sf },
  TabLineSel = { fg = p.strong, bg = p.sf_top, bold = true },
  TabLineFill = { bg = p.bg },
  Visual = { bg = p.primary_c },
  Search = { fg = p.on_secondary_c, bg = p.secondary_c },
  IncSearch = { fg = p.on_inverse, bg = p.inverse },
  CurSearch = { fg = p.on_inverse, bg = p.inverse },
  MatchParen = { fg = p.on_primary_c, bg = p.primary_c },
  Pmenu = { fg = p.strong, bg = p.sf_high },
  PmenuSel = { fg = p.on_inverse, bg = p.inverse },
  PmenuSbar = { bg = p.sf },
  PmenuThumb = { bg = p.primary },
  WildMenu = { fg = p.on_inverse, bg = p.inverse },
  QuickFixLine = { bg = p.secondary_c },
  Folded = { fg = p.comment, bg = p.sf_low, italic = true },
  FoldColumn = { fg = p.outline },
  Whitespace = { fg = p.ws },
  NonText = { fg = p.ws },
  SpecialKey = { fg = p.ws },
  EndOfBuffer = { fg = p.ws },
  Conceal = { fg = p.outline },
  Directory = { fg = p.blue },
  Title = { fg = p.blue, bold = true },
  ErrorMsg = { fg = p.red },
  WarningMsg = { fg = p.yellow },
  MoreMsg = { fg = p.blue },
  ModeMsg = { fg = p.fg, bold = true },
  Question = { fg = p.blue },

  -- Syntax (classic groups; minor groups default-link to these) ----------
  Comment = { fg = p.comment, italic = true },
  SpecialComment = { fg = p.doc, italic = true },
  Constant = { fg = p.green },
  String = { fg = p.green },
  Identifier = { fg = p.fg },
  Function = { fg = p.blue },
  Statement = { fg = p.fg },
  Operator = { fg = p.fg },
  PreProc = { fg = p.fg },
  Macro = { fg = p.magenta },
  Type = { fg = p.fg },
  Special = { fg = p.magenta },
  SpecialChar = { fg = p.cyan },
  Tag = { fg = p.blue },
  Delimiter = { fg = p.outline },
  Underlined = { underline = true },
  Todo = { fg = p.magenta, bold = true },
  Error = { fg = p.red },
  Added = { fg = p.green },
  Removed = { fg = p.red },
  Changed = { fg = p.yellow },

  -- Treesitter -----------------------------------------------------------
  ["@comment"] = { link = "Comment" },
  ["@comment.documentation"] = { fg = p.doc, italic = true },
  ["@constant"] = { fg = p.green },
  ["@constant.builtin"] = { fg = p.green },
  ["@number"] = { fg = p.green },
  ["@boolean"] = { fg = p.green },
  ["@string"] = { fg = p.green },
  ["@string.escape"] = { fg = p.cyan },
  ["@string.special"] = { fg = p.cyan },
  ["@string.special.url"] = { fg = p.outline, underdotted = true, sp = p.outline_var },
  ["@character"] = { fg = p.green },
  ["@character.special"] = { fg = p.cyan },
  ["@variable"] = { fg = p.fg },
  ["@variable.builtin"] = { fg = p.blue },
  ["@variable.parameter"] = { fg = p.orange },
  ["@variable.member"] = { fg = p.fg },
  ["@label"] = { fg = p.fg },
  ["@function"] = { fg = p.blue },
  ["@function.builtin"] = { fg = p.blue },
  ["@function.macro"] = { fg = p.magenta },
  ["@constructor"] = { fg = p.blue },
  ["@keyword"] = { fg = p.fg },
  ["@operator"] = { fg = p.fg },
  ["@punctuation"] = { fg = p.outline },
  ["@punctuation.delimiter"] = { fg = p.outline },
  ["@punctuation.bracket"] = { fg = p.outline },
  ["@punctuation.special"] = { fg = p.outline },
  ["@type"] = { fg = p.fg },
  ["@type.builtin"] = { fg = p.fg },
  ["@module"] = { fg = p.fg },
  ["@attribute"] = { fg = p.fg },
  ["@tag"] = { fg = p.blue },
  ["@tag.builtin"] = { fg = p.blue, bold = true },
  ["@tag.attribute"] = { fg = p.fg },
  ["@tag.delimiter"] = { fg = p.outline },
  ["@markup.heading"] = { fg = p.blue, bold = true },
  ["@markup.list"] = { fg = p.blue },
  ["@markup.list.checked"] = { fg = p.green },
  ["@markup.list.unchecked"] = { fg = p.outline },
  ["@markup.strong"] = { bold = true },
  ["@markup.italic"] = { italic = true },
  ["@markup.strikethrough"] = { strikethrough = true },
  ["@markup.link"] = { fg = p.blue },
  ["@markup.link.label"] = { fg = p.blue },
  ["@markup.link.url"] = { fg = p.outline, underdotted = true, sp = p.outline_var },
  ["@markup.quote"] = { fg = p.comment, italic = true },
  ["@markup.raw"] = { fg = p.doc },
  ["@markup.raw.block"] = { fg = p.doc, bg = p.sf_low },
  ["@diff.plus"] = { fg = p.green },
  ["@diff.minus"] = { fg = p.red },
  ["@diff.delta"] = { fg = p.yellow },

  -- LSP semantic tokens: align with the philosophy rather than letting
  -- servers repaint treesitter's work. Empty tables add nothing, so the
  -- treesitter capture underneath shows through.
  ["@lsp.type.parameter"] = { fg = p.orange },
  ["@lsp.type.macro"] = { fg = p.magenta },
  ["@lsp.type.enumMember"] = { fg = p.green },
  ["@lsp.type.function"] = { link = "Function" },
  ["@lsp.type.method"] = { link = "Function" },
  ["@lsp.type.comment"] = { link = "Comment" },
  ["@lsp.type.keyword"] = {},
  ["@lsp.type.operator"] = {},
  ["@lsp.type.variable"] = {},
  ["@lsp.type.property"] = {},
  ["@lsp.type.type"] = {},
  ["@lsp.type.class"] = {},
  ["@lsp.type.interface"] = {},
  ["@lsp.type.struct"] = {},
  ["@lsp.type.enum"] = {},
  ["@lsp.type.typeParameter"] = {},
  ["@lsp.type.namespace"] = {},
  ["@lsp.type.decorator"] = {},

  -- Diagnostics ----------------------------------------------------------
  DiagnosticError = { fg = p.red },
  DiagnosticWarn = { fg = p.yellow },
  DiagnosticInfo = { fg = p.blue },
  DiagnosticHint = { fg = p.magenta },
  DiagnosticUnderlineError = { undercurl = true, sp = p.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = p.yellow },
  DiagnosticUnderlineInfo = { underdotted = true, sp = p.blue },
  DiagnosticUnderlineHint = { underdotted = true, sp = p.magenta },
  DiagnosticDeprecated = { strikethrough = true },
  DiagnosticUnnecessary = { fg = p.faint },

  -- Diff -----------------------------------------------------------------
  DiffAdd = { bg = p.green_c },
  DiffDelete = { fg = p.red, bg = p.red_c },
  DiffChange = { bg = p.change_bg },
  DiffText = { bg = p.yellow_c },

  -- Spell ----------------------------------------------------------------
  SpellBad = { undercurl = true, sp = p.red },
  SpellCap = { undercurl = true, sp = p.blue },
  SpellLocal = { undercurl = true, sp = p.cyan },
  SpellRare = { undercurl = true, sp = p.magenta },

  -- STRUCTURAL LAYER (optional) — uncomment for cyan architecture cues
  -- ["@type"] = { fg = p.cyan },
  -- ["@type.builtin"] = { fg = p.cyan, bold = true },
  -- ["@module"] = { fg = p.cyan },
  -- ["@attribute"] = { fg = p.cyan },
}

for name, opts in pairs(groups) do
  vim.api.nvim_set_hl(0, name, opts)
end

for i, color in ipairs(p.term) do
  vim.g["terminal_color_" .. (i - 1)] = color
end
