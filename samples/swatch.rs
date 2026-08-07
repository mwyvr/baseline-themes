//! Render the baseline dark accents as ANSI swatches with WCAG contrast.

use std::num::ParseIntError;
use std::process;

const SURFACE: &str = "#111418";
/// WCAG AA for normal text.
const MIN_RATIO: f64 = 4.5;

const ACCENTS: [(&str, &str); 7] = [
    ("green", "#A1D39A"),
    ("blue", "#AAC7FF"),
    ("orange", "#FDB975"),
    ("cyan", "#83D3E3"),
    ("magenta", "#EBB5ED"),
    ("yellow", "#D4C871"),
    ("red", "#FFB3AC"),
];

fn rgb(hex: &str) -> Result<(u8, u8, u8), ParseIntError> {
    let digits = hex.trim_start_matches('#');
    Ok((
        u8::from_str_radix(&digits[0..2], 16)?,
        u8::from_str_radix(&digits[2..4], 16)?,
        u8::from_str_radix(&digits[4..6], 16)?,
    ))
}

fn luminance((r, g, b): (u8, u8, u8)) -> f64 {
    let linear = |channel: u8| {
        let v = f64::from(channel) / 255.0;
        if v <= 0.04045 {
            v / 12.92
        } else {
            ((v + 0.055) / 1.055).powf(2.4)
        }
    };
    0.2126 * linear(r) + 0.7152 * linear(g) + 0.0722 * linear(b)
}

fn contrast(a: f64, b: f64) -> f64 {
    let (hi, lo) = if a > b { (a, b) } else { (b, a) };
    (hi + 0.05) / (lo + 0.05)
}

fn grade(ratio: f64) -> &'static str {
    match ratio {
        r if r >= 7.0 => "AAA",
        r if r >= MIN_RATIO => "AA",
        r if r >= 3.0 => "AA-LARGE",
        _ => "FAIL",
    }
}

fn main() {
    let background = match rgb(SURFACE) {
        Ok(color) => luminance(color),
        Err(err) => {
            eprintln!("bad surface {SURFACE}: {err}");
            process::exit(1);
        }
    };
    for (name, hex) in ACCENTS {
        let (r, g, b) = rgb(hex).unwrap_or_else(|err| {
            eprintln!("{name}: {err}");
            process::exit(1);
        });
        let ratio = contrast(luminance((r, g, b)), background);
        println!(
            "\x1b[48;2;{r};{g};{b}m    \x1b[0m {name:<8} {hex}  {ratio:5.2}:1  {}",
            grade(ratio)
        );
    }
}
