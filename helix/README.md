# baseline for Helix

```sh
cp *.toml ~/.config/helix/themes/
```

`config.toml` — follows OS appearance on terminals supporting mode 2031
(Ghostty, kitty, WezTerm, foot):

```toml
[theme]
dark = "baseline_dark"
light = "baseline_light"
```

For remote Helix, copy the themes to the host. Styled underlines
(diagnostics, URLs) and appearance detection depend on the terminal's
terminfo being installed there; see [../ghostty/](../ghostty/) for the
Ghostty one-liner.
