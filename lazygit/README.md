# baseline for lazygit

lazygit has no light/dark detection. Merge the `gui.theme` block into
`config.yml` directly, or select a fragment at launch via the config chain
(later files override earlier). A shell function makes it follow the OS on
macOS and stay explicit elsewhere:

```sh
lg() {
    local mode=${BASELINE_MODE:-}
    if [[ -z $mode ]]; then
        if command -v defaults >/dev/null 2>&1; then
            defaults read -g AppleInterfaceStyle &>/dev/null && mode=dark || mode=light
        else
            mode=dark   # non-macOS: no appearance to query
        fi
    fi
    lazygit --use-config-file="$HOME/.config/lazygit/config.yml,$HOME/.config/lazygit/baseline-${mode}.yml" "$@"
}
```

Mode is sampled at launch; `BASELINE_MODE=light lg` overrides anywhere,
including over SSH.
