# baseline for ls

`ls` paints setuid/setgid files and world-writable directories with
foreground-on-background pairs that assume dark ANSI backgrounds —
GNU's `su=37;41` (white on red), BSD's `ab` (black on red), and friends.
Against baseline those collapse: in dark mode the backgrounds are light
pastels, in light mode they are dark inks, and no fixed pairing survives
both modes because ls color variables cannot follow the terminal.

`baseline.sh` restyles the offending classes as foreground-only, which
works in both modes by construction and matches the theme's manner:

| class                   | GNU (`LS_COLORS`) | BSD (`LSCOLORS`) | style        |
| ----------------------- | ----------------- | ---------------- | ------------ |
| setuid                  | `su=01;31`        | pos 8 `Bx`       | bold red     |
| setgid                  | `sg=01;33`        | pos 9 `Dx`       | bold yellow  |
| capabilities            | `ca=04;31`        | —                | underl. red  |
| sticky + other-writable | `tw=04;36`        | pos 10 `Gx`      | cyan, strong |
| other-writable dir      | `ow=36`           | pos 11 `gx`      | cyan         |
| sticky dir              | `st=04;34`        | —                | underl. blue |
| block / char devices    | (stock)           | pos 6–7 `Ex`     | bold blue    |

Cyan for the writable-directory classes keeps them distinct from ordinary
directories (blue) while staying in the theme's structure color. BSD's
format has no underline, so bold stands in for weight there; it also has
no capability or plain-sticky slots. BSD's stock device pairs use
backgrounds too, so positions 6–7 are restyled; the GNU defaults for
devices use a black background (benign against baseline) and are left
alone.

## Usage

Both variables are exported unconditionally; each is inert where its ls
does not read it, and zsh completion menus (`list-colors`) consume
`LS_COLORS` syntax on every platform — including stock macOS.

GNU ls (Linux, or coreutils `gls` on macOS) — order matters; append
after the base database, before anything that snapshots `LS_COLORS`:

```sh
eval "$(dircolors -b)"
. ~/git/baseline-themes/dircolors/baseline.sh
```

BSD ls (stock macOS) — colors activate via `CLICOLOR=1` (or `ls -G`):

```sh
export CLICOLOR=1
. ~/git/baseline-themes/dircolors/baseline.sh
```
