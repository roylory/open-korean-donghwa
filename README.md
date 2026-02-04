# Open Donghwa (평범한 동화책)

This repository contains a growing library of **open‑source Korean storybooks** accompanied by AI‑generated illustrations.  Each story lives in its own Quarto file and can be rendered into a standalone PDF.  The project aims to provide creative, culturally resonant tales free from copyright complications.

## How it works

- Stories are written in [Quarto](https://quarto.org/) using Markdown syntax (`*.qmd`).
- Each book lives in `src/<book-id>/` with its source at `src/<book-id>/<book-id>.qmd`.
- Illustrations live in `src/<book-id>/images/` and are linked with relative paths like `images/scene-01.png`.
- The repository includes a shared `_quarto.yml` that specifies Korean fonts and page settings.

## Building PDFs

To build **all** books into the `build/` folder:

```bash
./build.sh
```

To build a **single** book:

```bash
quarto render src/001-sun-and-wind/001-sun-and-wind.qmd --to pdf --output-dir build --output 001-sun-and-wind.pdf
```

For quick HTML preview, swap the format:

```bash
quarto render src/001-sun-and-wind/001-sun-and-wind.qmd --to html --output-dir build
```

## Contributing

We welcome new stories and art!  Please observe the following guidelines:

1. **Originality:** Only submit text and images that you own or are authorized to license.  Do not copy existing copyrighted stories or artwork.
2. **AI images:** When you generate illustrations using an AI tool, record the prompt, model/version, and any seeds used.  Include this metadata in the commit message or a separate provenance file so future maintainers understand the source.
3. **License sign‑off:** All contributions are licensed under the terms defined in the `LICENSE` file.  By submitting content you agree to these terms.

See `CONTRIBUTING.md` (not yet included) for more details on style and submission conventions.

## License

This project is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0).  See [`LICENSE`](LICENSE) for the full text.
