# baseline samples

One small program — `swatch`, which prints the theme's own accents with
their WCAG contrast against the surface — implemented identically across
several languages. The program is not the point; each implementation
exercises the token families the theme makes decisions about: constants,
strings and escape sequences, functions and calls, parameters, keywords and
control flow, error handling, and each language's meta layer (decorators in
Python, macros in Rust, the preprocessor in C, interfaces and type unions
in TypeScript).

All implementations print the same report:

```sh
python3 swatch.py
go run swatch.go
rustc --edition 2021 swatch.rs -o swatch && ./swatch
bash swatch.sh
cc -Wall swatch.c -lm -o swatchc && ./swatchc
tsc swatch.ts && node swatch.js
```

## Screenshots

Rendered in Helix as side-by-side pairs, named `<left>-<right>-<mode>.png`;
browse them all in the [gallery](screenshots/).

| Languages         | Sources                                          | Dark                                          | Light                                           |
| ----------------- | ------------------------------------------------ | --------------------------------------------- | ----------------------------------------------- |
| C · Go            | [swatch.c](swatch.c) · [swatch.go](swatch.go)    | [dark](screenshots/c-go-dark.png)             | [light](screenshots/c-go-light.png)             |
| Python · Rust     | [swatch.py](swatch.py) · [swatch.rs](swatch.rs)  | [dark](screenshots/python-rust-dark.png)      | [light](screenshots/python-rust-light.png)      |
| Bash · TypeScript | [swatch.sh](swatch.sh) · [swatch.ts](swatch.ts)  | [dark](screenshots/shell-typescript-dark.png) | [light](screenshots/shell-typescript-light.png) |
