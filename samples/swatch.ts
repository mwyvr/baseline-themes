// Render the baseline dark accents as ANSI swatches with WCAG contrast.

interface Swatch {
    readonly name: string;
    readonly hex: string;
}

type Grade = "AAA" | "AA" | "AA-LARGE" | "FAIL";

const SURFACE = "#111418";
/** WCAG AA for normal text. */
const MIN_RATIO = 4.5;

const ACCENTS: Swatch[] = [
    { name: "green", hex: "#A1D39A" },
    { name: "blue", hex: "#AAC7FF" },
    { name: "orange", hex: "#FDB975" },
    { name: "cyan", hex: "#83D3E3" },
    { name: "magenta", hex: "#EBB5ED" },
    { name: "yellow", hex: "#D4C871" },
    { name: "red", hex: "#FFB3AC" },
];

function rgb(hex: string): [number, number, number] {
    if (!/^#[0-9a-fA-F]{6}$/.test(hex)) {
        throw new Error(`not a hex color: ${hex}`);
    }
    const n = parseInt(hex.slice(1), 16);
    return [(n >> 16) & 0xff, (n >> 8) & 0xff, n & 0xff];
}

const linear = (channel: number): number => {
    const v = channel / 255;
    return v <= 0.04045 ? v / 12.92 : ((v + 0.055) / 1.055) ** 2.4;
};

const luminance = ([r, g, b]: [number, number, number]): number =>
    0.2126 * linear(r) + 0.7152 * linear(g) + 0.0722 * linear(b);

function contrast(a: number, b: number): number {
    const [hi, lo] = a > b ? [a, b] : [b, a];
    return (hi + 0.05) / (lo + 0.05);
}

function grade(ratio: number): Grade {
    if (ratio >= 7) return "AAA";
    if (ratio >= MIN_RATIO) return "AA";
    if (ratio >= 3) return "AA-LARGE";
    return "FAIL";
}

const background = luminance(rgb(SURFACE));
for (const { name, hex } of ACCENTS) {
    const [r, g, b] = rgb(hex);
    const ratio = contrast(luminance([r, g, b]), background);
    const block = `\x1b[48;2;${r};${g};${b}m    \x1b[0m`;
    console.log(
        `${block} ${name.padEnd(8)} ${hex}  ${ratio.toFixed(2).padStart(5)}:1  ${grade(ratio)}`,
    );
}
