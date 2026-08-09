# baseline for Vim

An honest reduction: Vim's regex-based syntax groups are coarser than
treesitter, so this carries the philosophy at lower resolution — constants
and strings green, functions blue, escapes cyan, punctuation receded,
keywords and types at the default foreground. Neovim users should prefer
[nvim/colors/baseline.lua](../nvim/) for the full experience; this file
exists because Vim ships everywhere and deserves better defaults.

```sh
cp colors/baseline.vim ~/.vim/colors/
```

```vim
colorscheme baseline
```

Requires a truecolor terminal. The scheme enables `termguicolors` itself
when the terminal advertises truecolor (`$COLORTERM`); set it manually in
`.vimrc` if your terminal supports truecolor without advertising it.

A Vim quirk this file accounts for: even with `termguicolors` on, Vim
takes *colors* from `guifg`/`guibg` but *attributes* (bold, underline)
from `cterm=` — unlike Neovim, which uses `gui=` throughout. Every group
here therefore sets both, which is what keeps stock attribute defaults
like `CursorLine cterm=underline` from bleeding through a gui-only theme.

Both modes live in the one file, selected by
`'background'`; `:set background=dark|light` switches live. Vim's own
background detection is unreliable in some environments, so setting it
explicitly in `.vimrc` before `colorscheme baseline` is the dependable
arrangement.
