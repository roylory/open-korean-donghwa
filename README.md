# Open Donghwa (오픈 동화책)

This repository contains a growing library of **open‑source Korean storybooks** accompanied by AI‑generated illustrations. Each story lives in its own Quarto file and can be rendered into a standalone PDF. The project aims to provide creative, culturally resonant tales free from copyright complications.

## How to install

Install `quarto` first.

In Mac,

```bash
brew install --cask quarto
```

Install tinytex.

```bash
quarto install tinytex
```

Install Korean font.

```bash
brew install --cask font-noto-serif-cjk-kr
```

## How to build

Build for all.

```bash
./build.sh --all
```

Build only a book.

```bash
./build.sh 001-dangun
```

## Contributing

We welcome new stories and art!

## License

This project is licensed under the Creative Commons Attribution 4.0 International License (CC BY 4.0). See [`LICENSE`](LICENSE) for the full text.
