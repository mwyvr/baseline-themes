#!/usr/bin/env bash
# Render the baseline dark accents as ANSI swatches with WCAG contrast.
# Portable to bash 3.2 (macOS): no associative arrays.
set -euo pipefail

readonly SURFACE="#111418"

names=(green blue orange cyan magenta yellow red)
hexes=("#A1D39A" "#AAC7FF" "#FDB975" "#83D3E3" "#EBB5ED" "#D4C871" "#FFB3AC")

# hex_to_rgb '#RRGGBB' -> sets R G B
hex_to_rgb() {
    local digits=${1#\#}
    R=$((16#${digits:0:2}))
    G=$((16#${digits:2:2}))
    B=$((16#${digits:4:2}))
}

# contrast R G B (vs SURFACE) -> ratio, two decimals
contrast() {
    hex_to_rgb "$SURFACE"
    awk -v r="$1" -v g="$2" -v b="$3" -v sr="$R" -v sg="$G" -v sb="$B" '
    function lin(c) { c /= 255; return c <= 0.04045 ? c / 12.92 : ((c + 0.055) / 1.055) ^ 2.4 }
    function lum(r, g, b) { return 0.2126 * lin(r) + 0.7152 * lin(g) + 0.0722 * lin(b) }
    BEGIN {
        a = lum(r, g, b); s = lum(sr, sg, sb)
        if (s > a) { t = a; a = s; s = t }
        printf "%.2f", (a + 0.05) / (s + 0.05)
    }'
}

# grade RATIO*100 as integer; 450 is WCAG AA for normal text
grade() {
    if (( $1 >= 700 )); then echo "AAA"
    elif (( $1 >= 450 )); then echo "AA"
    elif (( $1 >= 300 )); then echo "AA-LARGE"
    else echo "FAIL"
    fi
}

main() {
    local i ratio scaled
    for i in "${!names[@]}"; do
        hex_to_rgb "${hexes[i]}"
        local r=$R g=$G b=$B
        ratio=$(contrast "$r" "$g" "$b")
        scaled=${ratio/./}   # "10.79" -> 1079
        printf '\033[48;2;%d;%d;%dm    \033[0m %-8s %s  %5s:1  %s\n' \
            "$r" "$g" "$b" "${names[i]}" "${hexes[i]}" "$ratio" "$(grade "$scaled")"
    done
}

main "$@"
