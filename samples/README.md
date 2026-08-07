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

Rendered in Helix with the baseline themes. Naming convention:
`screenshots/<language>-<mode>.png`.

| Language   | Source                     | Dark                                    | Light                                     |
| ---------- | -------------------------- | --------------------------------------- | ----------------------------------------- |
| Python     | [swatch.py](swatch.py)     | [dark](screenshots/python-dark.png)     | [light](screenshots/python-light.png)     |
| Go         | [swatch.go](swatch.go)     | [dark](screenshots/go-dark.png)         | [light](screenshots/go-light.png)         |
| Rust       | [swatch.rs](swatch.rs)     | [dark](screenshots/rust-dark.png)       | [light](screenshots/rust-light.png)       |
| Bash       | [swatch.sh](swatch.sh)     | [dark](screenshots/bash-dark.png)       | [light](screenshots/bash-light.png)       |
| C          | [swatch.c](swatch.c)       | [dark](screenshots/c-dark.png)          | [light](screenshots/c-light.png)          |
| TypeScript | [swatch.ts](swatch.ts)     | [dark](screenshots/typescript-dark.png) | [light](screenshots/typescript-light.png) |
