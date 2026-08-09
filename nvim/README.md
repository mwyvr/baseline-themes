# baseline for Neovim

One themefile file provides both light and dark modes; the colorscheme reads
`'background'` and Neovim re-sources it on every `:set background=dark|light`,
so switching is live.

```sh
cp colors/baseline.lua ~/.config/nvim/colors/
```

```vim
colorscheme baseline
```

Neovim 0.10+ queries the terminal's background color at startup and sets
`'background'` to match, so the right mode loads automatically inside a
baseline-themed terminal. Appearance changes mid-session are not followed;
`:set background=light` (or a plugin such as auto-dark-mode.nvim) reapplies
instantly.

Coverage is deliberately core: editor UI, treesitter captures, diagnostics,
diff, spell, and the built-in terminal palette. Plugin highlight groups are
out of scope; most plugins fall back onto these groups sensibly. LSP
semantic tokens are aligned with baseline's philosophy rather than allowed to
repaint treesitter's work — parameters stay orange, macros magenta, and
keyword/type/variable tokens add nothing.

The optional cyan structural layer (types, modules, attributes) ships
commented out at the end of the file, mirroring the Helix themes.
