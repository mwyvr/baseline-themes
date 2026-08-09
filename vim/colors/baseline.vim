" baseline — dual-mode Vim colorscheme, sibling of the Helix themes.
" Legacy syntax groups only; Vim's regex highlighting is coarser than
" treesitter, so this is a reduced rendering of the philosophy. Neovim
" users should prefer nvim/colors/baseline.lua for the full experience.
" Requires a truecolor terminal and :set termguicolors (or a GUI).

" This theme defines truecolor (gui*) values only. If the terminal
" advertises truecolor and termguicolors is off, enable it — otherwise Vim
" silently falls back to its stock cterm palette and none of this applies.
if has("termguicolors") && !&termguicolors
      \ && ($COLORTERM ==# "truecolor" || $COLORTERM ==# "24bit")
  set termguicolors
endif

hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "baseline"

if &background ==# "light"
  let s:bg      = "#F8F9FF" | let s:fg      = "#42474E" | let s:strong = "#191C20"
  let s:sf_low  = "#F2F3F9" | let s:sf      = "#EDEDF4" | let s:sf_top = "#E1E2E8"
  let s:outline = "#73777F" | let s:outvar  = "#C3C7CF"
  let s:comment = "#77777A" | let s:doc     = "#5E5E61" | let s:linenr = "#919093"
  let s:primary = "#35618E" | let s:prim_c  = "#D1E4FF" | let s:on_prim = "#001D36"
  let s:sec_c   = "#D7E3F8" | let s:on_sec  = "#101C2B"
  let s:inv     = "#2E3035" | let s:on_inv  = "#EFF0F6"
  let s:green   = "#3C683A" | let s:blue    = "#415F90" | let s:orange = "#865318"
  let s:cyan    = "#006876" | let s:magenta = "#7B4E7F" | let s:yellow = "#685F12"
  let s:red     = "#BA1A1A"
  let s:green_c = "#BDF0B5" | let s:red_c   = "#FFDAD6" | let s:yel_c  = "#F1E48A"
  let s:chg_bg  = "#F2F3F9" | let s:ws      = "#C3C7CF"
else
  let s:bg      = "#111418" | let s:fg      = "#C3C7CF" | let s:strong = "#E1E2E8"
  let s:sf_low  = "#191C20" | let s:sf      = "#1D2024" | let s:sf_top = "#32353A"
  let s:outline = "#8D9199" | let s:outvar  = "#43474E"
  let s:comment = "#77777A" | let s:doc     = "#909094" | let s:linenr = "#5E5E61"
  let s:primary = "#A0CAFD" | let s:prim_c  = "#194975" | let s:on_prim = "#D1E4FF"
  let s:sec_c   = "#3B4858" | let s:on_sec  = "#D7E3F7"
  let s:inv     = "#E1E2E8" | let s:on_inv  = "#2E3135"
  let s:green   = "#A1D39A" | let s:blue    = "#AAC7FF" | let s:orange = "#FDB975"
  let s:cyan    = "#83D3E3" | let s:magenta = "#EBB5ED" | let s:yellow = "#D4C871"
  let s:red     = "#FFB3AC"
  let s:green_c = "#235024" | let s:red_c   = "#73332F" | let s:yel_c  = "#4F4800"
  let s:chg_bg  = "#191C20" | let s:ws      = "#32353A"
endif

function! s:hi(group, fg, bg, attr, sp) abort
  let l:cmd = "hi " . a:group
  let l:cmd .= " guifg=" . (a:fg ==# "" ? "NONE" : a:fg)
  let l:cmd .= " guibg=" . (a:bg ==# "" ? "NONE" : a:bg)
  let l:attr = a:attr ==# "" ? "NONE" : a:attr
  " Vim sources attributes from cterm= in terminals even under
  " termguicolors (colors come from gui*); term= covers colorless
  " terminals. Mirror into all three so no stock default survives.
  let l:cmd .= " gui=" . l:attr . " cterm=" . l:attr . " term=" . l:attr
  if a:sp !=# ""
    let l:cmd .= " guisp=" . a:sp
  endif
  execute l:cmd
endfunction

" UI
call s:hi("Normal", s:fg, s:bg, "", "")
call s:hi("CursorLine", "", s:sf, "", "")
call s:hi("CursorColumn", "", s:sf, "", "")
call s:hi("ColorColumn", "", s:sf_low, "", "")
call s:hi("CursorLineNr", s:primary, "", "bold", "")
call s:hi("LineNr", s:linenr, "", "", "")
call s:hi("SignColumn", s:outline, s:bg, "", "")
call s:hi("VertSplit", s:outvar, "", "", "")
call s:hi("StatusLine", s:strong, s:sf, "NONE", "")
call s:hi("StatusLineNC", s:outline, s:sf_low, "NONE", "")
call s:hi("TabLine", s:outline, s:sf, "NONE", "")
call s:hi("TabLineSel", s:strong, s:sf_top, "bold", "")
call s:hi("TabLineFill", "", s:bg, "NONE", "")
call s:hi("Visual", "", s:prim_c, "", "")
call s:hi("Search", s:on_sec, s:sec_c, "", "")
call s:hi("IncSearch", s:on_inv, s:inv, "", "")
call s:hi("MatchParen", s:on_prim, s:prim_c, "", "")
call s:hi("Pmenu", s:strong, s:sf, "", "")
call s:hi("PmenuSel", s:on_inv, s:inv, "", "")
call s:hi("PmenuSbar", "", s:sf, "", "")
call s:hi("PmenuThumb", "", s:primary, "", "")
call s:hi("WildMenu", s:on_inv, s:inv, "", "")
call s:hi("Folded", s:comment, s:sf_low, "italic", "")
call s:hi("FoldColumn", s:outline, "", "", "")
call s:hi("NonText", s:ws, "", "", "")
call s:hi("SpecialKey", s:ws, "", "", "")
call s:hi("EndOfBuffer", s:ws, "", "", "")
call s:hi("Conceal", s:outline, "", "", "")
call s:hi("Directory", s:blue, "", "", "")
call s:hi("Title", s:blue, "", "bold", "")
call s:hi("ErrorMsg", s:red, "", "", "")
call s:hi("WarningMsg", s:yellow, "", "", "")
call s:hi("MoreMsg", s:blue, "", "", "")
call s:hi("ModeMsg", s:fg, "", "bold", "")
call s:hi("Question", s:blue, "", "", "")
call s:hi("QuickFixLine", "", s:sec_c, "", "")

" Syntax — minor groups (Conditional, Number, Structure, ...) default-link
" to these majors, so the philosophy propagates without listing them.
call s:hi("Comment", s:comment, "", "italic", "")
call s:hi("SpecialComment", s:doc, "", "italic", "")
call s:hi("Constant", s:green, "", "", "")
call s:hi("String", s:green, "", "", "")
call s:hi("Identifier", s:fg, "", "NONE", "")
call s:hi("Function", s:blue, "", "", "")
call s:hi("Statement", s:fg, "", "NONE", "")
call s:hi("Operator", s:fg, "", "", "")
call s:hi("PreProc", s:fg, "", "", "")
call s:hi("Macro", s:magenta, "", "", "")
call s:hi("Type", s:fg, "", "NONE", "")
call s:hi("Special", s:magenta, "", "", "")
call s:hi("SpecialChar", s:cyan, "", "", "")
call s:hi("Tag", s:blue, "", "", "")
call s:hi("Delimiter", s:outline, "", "", "")
call s:hi("Underlined", "", "", "underline", "")
call s:hi("Todo", s:magenta, "", "bold", "")
call s:hi("Error", s:red, "", "", "")

" Diff
call s:hi("DiffAdd", "", s:green_c, "", "")
call s:hi("DiffDelete", s:red, s:red_c, "", "")
call s:hi("DiffChange", "", s:chg_bg, "", "")
call s:hi("DiffText", "", s:yel_c, "", "")

" Spell
call s:hi("SpellBad", "", "", "undercurl", s:red)
call s:hi("SpellCap", "", "", "undercurl", s:blue)
call s:hi("SpellLocal", "", "", "undercurl", s:cyan)
call s:hi("SpellRare", "", "", "undercurl", s:magenta)

delfunction s:hi
