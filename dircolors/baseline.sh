# baseline ls color overrides — source from your shell init.
#
# ls colors special-permission files and world-writable dirs with
# fg-ON-bg pairs designed for terminals whose ANSI accents are dark.
# baseline's accents are light pastels in dark mode and dark inks in
# light mode, so any fixed pairing is unreadable in one mode. These
# restyle the offending classes as foreground-only: mode-proof, and
# consistent with the theme (distinction by hue and weight, no
# background fields).
#
# Both variables are set unconditionally — each is inert where its ls
# does not read it, and zsh completion (list-colors) consumes LS_COLORS
# syntax on every platform.

# GNU ls: append after `eval "$(dircolors -b)"`; later duplicate keys win.
# su/sg setuid/setgid, ca capabilities, tw/ow sticky/other-writable dirs,
# st sticky dir.
LS_COLORS="${LS_COLORS}:su=01;31:sg=01;33:ca=04;31:tw=04;36:ow=36:st=04;34"
export LS_COLORS

# BSD ls (macOS): eleven fg/bg letter pairs; x = default background,
# capitals = bold. Positions 1-5 keep the stock hues (dir, symlink,
# socket, pipe, executable); 6-11 replace the stock background pairs:
#   6 block dev   Ex  bold blue      (was eg: blue on cyan)
#   7 char dev    Ex  bold blue      (was ed: blue on yellow)
#   8 setuid      Bx  bold red       (was ab: black on red)
#   9 setgid      Dx  bold yellow    (was ag: black on cyan)
#  10 sticky+ow   Gx  bold cyan      (was ac: black on green)
#  11 other-writ  gx  cyan           (was ad: black on yellow)
# Pair with CLICOLOR=1 (or -G) to activate colors at all.
LSCOLORS="exfxcxdxbxExExBxDxGxgx"
export LSCOLORS
