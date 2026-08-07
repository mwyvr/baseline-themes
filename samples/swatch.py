#!/usr/bin/env python3
"""Render the baseline dark accents as ANSI swatches with WCAG contrast."""

from dataclasses import dataclass

SURFACE = "#111418"
MIN_RATIO = 4.5  # WCAG AA for normal text

ACCENTS = [
    ("green", "#A1D39A"),
    ("blue", "#AAC7FF"),
    ("orange", "#FDB975"),
    ("cyan", "#83D3E3"),
    ("magenta", "#EBB5ED"),
    ("yellow", "#D4C871"),
    ("red", "#FFB3AC"),
]


@dataclass(frozen=True)
class Swatch:
    name: str
    hex: str

    def rgb(self) -> tuple[int, int, int]:
        digits = self.hex.lstrip("#")
        if len(digits) != 6:
            raise ValueError(f"not a 6-digit hex color: {self.hex!r}")
        r, g, b = (int(digits[i : i + 2], 16) for i in (0, 2, 4))
        return r, g, b


def luminance(rgb: tuple[int, int, int]) -> float:
    def linear(channel: int) -> float:
        v = channel / 255
        return v / 12.92 if v <= 0.04045 else ((v + 0.055) / 1.055) ** 2.4

    r, g, b = rgb
    return 0.2126 * linear(r) + 0.7152 * linear(g) + 0.0722 * linear(b)


def contrast(a: float, b: float) -> float:
    hi, lo = (a, b) if a > b else (b, a)
    return (hi + 0.05) / (lo + 0.05)


def grade(ratio: float) -> str:
    if ratio >= 7.0:
        return "AAA"
    if ratio >= MIN_RATIO:
        return "AA"
    if ratio >= 3.0:
        return "AA-LARGE"
    return "FAIL"


def main() -> None:
    background = luminance(Swatch("surface", SURFACE).rgb())
    for name, hex_ in ACCENTS:
        r, g, b = Swatch(name, hex_).rgb()
        ratio = contrast(luminance((r, g, b)), background)
        block = f"\x1b[48;2;{r};{g};{b}m    \x1b[0m"
        print(f"{block} {name:<8} {hex_}  {ratio:5.2f}:1  {grade(ratio)}")


if __name__ == "__main__":
    main()
