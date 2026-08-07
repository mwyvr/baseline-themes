// Command swatch renders the baseline dark accents as ANSI swatches with
// their WCAG contrast against the theme surface.
package main

import (
	"fmt"
	"math"
	"os"
)

const surface = "#111418"

// minRatio is WCAG AA for normal text.
const minRatio = 4.5

type swatch struct {
	name, hex string
}

var accents = []swatch{
	{"green", "#A1D39A"},
	{"blue", "#AAC7FF"},
	{"orange", "#FDB975"},
	{"cyan", "#83D3E3"},
	{"magenta", "#EBB5ED"},
	{"yellow", "#D4C871"},
	{"red", "#FFB3AC"},
}

func (s swatch) rgb() (r, g, b int, err error) {
	if len(s.hex) != 7 || s.hex[0] != '#' {
		return 0, 0, 0, fmt.Errorf("not a hex color: %q", s.hex)
	}
	_, err = fmt.Sscanf(s.hex, "#%02x%02x%02x", &r, &g, &b)
	return r, g, b, err
}

func luminance(r, g, b int) float64 {
	linear := func(channel int) float64 {
		v := float64(channel) / 255
		if v <= 0.04045 {
			return v / 12.92
		}
		return math.Pow((v+0.055)/1.055, 2.4)
	}
	return 0.2126*linear(r) + 0.7152*linear(g) + 0.0722*linear(b)
}

func contrast(a, b float64) float64 {
	if b > a {
		a, b = b, a
	}
	return (a + 0.05) / (b + 0.05)
}

func grade(ratio float64) string {
	switch {
	case ratio >= 7:
		return "AAA"
	case ratio >= minRatio:
		return "AA"
	case ratio >= 3:
		return "AA-LARGE"
	default:
		return "FAIL"
	}
}

func main() {
	sr, sg, sb, err := swatch{"surface", surface}.rgb()
	if err != nil {
		fmt.Fprintln(os.Stderr, err)
		os.Exit(1)
	}
	background := luminance(sr, sg, sb)
	for _, s := range accents {
		r, g, b, err := s.rgb()
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
			os.Exit(1)
		}
		ratio := contrast(luminance(r, g, b), background)
		fmt.Printf("\x1b[48;2;%d;%d;%dm    \x1b[0m %-8s %s  %5.2f:1  %s\n",
			r, g, b, s.name, s.hex, ratio, grade(ratio))
	}
}
