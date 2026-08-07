# baseline for Ghostty

```sh
cp baseline-* ~/.config/ghostty/themes/
```

The paired form enables appearance-following and correct scheme reporting;
do not pin a single `theme`:

```
theme = light:baseline-light,dark:baseline-dark
```

For remote hosts, install Ghostty's terminfo once per host:

```sh
infocmp -x xterm-ghostty | ssh <host> -- tic -x -
```

Styled underlines require `TERM=xterm-ghostty` end to end; a shell or ssh
config forcing `xterm-256color` silently downgrades them.

## Stuck colors after an appearance switch

Changing the macOS appearance while a TUI application (e.g. Helix) is
running can leave the terminal stranded in the previous mode's colors even
after the application exits — the app-set colors are retained as an
override, and `clear` does not release them. Reset explicitly:

```sh
alias unstick='printf "\033]110\007\033]111\007\033]104\007"'  # reset default fg, bg, ANSI palette
```

Detection keeps working while stuck (`printf '\e[?996n'` reports the new
mode); only the applied colors lag.
