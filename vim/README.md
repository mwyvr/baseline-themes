# baseline for Vim

A reduced implementation following baseline's Helix implementation, as
Vim's regex-based syntax groups are coarser than treesitter: constants
and strings green, functions blue, escapes cyan, punctuation receded,
keywords and types at the default foreground. Neovim users should prefer
[nvim/colors/baseline.lua](../nvim/) for the full experience; this file exists
because Vim ships everywhere and deserves better defaults.

```sh
cp colors/baseline.vim ~/.vim/colors/
```

```vim
set termguicolors
colorscheme baseline
```

Requires a truecolor terminal. Both modes live in the one file, selected by
`'background'`; `:set background=dark|light` switches live. Set `'background'`
explicitly in `.vimrc` before `colorscheme baseline` is the dependable
arrangement.
