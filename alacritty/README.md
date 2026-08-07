# baseline for Alacritty

```sh
cp baseline-*.toml ~/.config/alacritty/
```

Import one theme in `alacritty.toml` (top-level `import` before 0.14):

```toml
[general]
import = ["~/.config/alacritty/baseline-dark.toml"]
```

Alacritty has no appearance following, but live-reloads its config: point
the import at a symlink and flipping the symlink switches a running
terminal.
