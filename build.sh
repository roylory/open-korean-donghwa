#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_DIR="$ROOT_DIR/src"
BUILD_DIR="$ROOT_DIR/build"

usage() {
  cat <<EOF
Usage: $(basename "$0") [--all | <folder-name>]

Build Quarto PDFs from src/.
  --all          Build all folders (default behavior).
  <folder-name>  Build only the matching folder in src/.
EOF
}

build_all=true
target_folder=""

if [ "${1:-}" = "--help" ] || [ "${1:-}" = "-h" ]; then
  usage
  exit 0
fi

if [ "$#" -gt 1 ]; then
  echo "Expected at most one argument." >&2
  usage >&2
  exit 1
fi

if [ "$#" -eq 1 ]; then
  if [ "$1" = "--all" ]; then
    build_all=true
  elif [[ "$1" = -* ]]; then
    echo "Unknown option: $1" >&2
    usage >&2
    exit 1
  else
    build_all=false
    target_folder="${1%/}"
    target_folder="${target_folder#src/}"
  fi
fi

mkdir -p "$BUILD_DIR"

if [ ! -d "$SRC_DIR" ]; then
  echo "No src directory found at $SRC_DIR" >&2
  exit 1
fi

if ! command -v quarto >/dev/null 2>&1; then
  echo "Quarto is not installed or not in PATH." >&2
  echo "Install Quarto, then rerun this script." >&2
  echo "Download: https://quarto.org/docs/get-started/" >&2
  exit 1
fi

books=()

if [ "$build_all" = true ]; then
  while IFS= read -r book; do
    if [ -n "$book" ]; then
      books+=("$book")
    fi
  done < <(find "$SRC_DIR" -mindepth 2 -maxdepth 2 -name "*.qmd" -print | sort)
else
  target_dir="$SRC_DIR/$target_folder"
  if [ ! -d "$target_dir" ]; then
    echo "Folder not found: $target_dir" >&2
    exit 1
  fi
  while IFS= read -r book; do
    if [ -n "$book" ]; then
      books+=("$book")
    fi
  done < <(find "$target_dir" -mindepth 1 -maxdepth 1 -name "*.qmd" -print | sort)
fi

if [ "${#books[@]}" -eq 0 ]; then
  echo "No .qmd files found to build." >&2
  exit 1
fi

for book in "${books[@]}"; do
  book_name="$(basename "$book" .qmd)"
  output_file="$book_name.pdf"
  echo "Rendering ${book#$ROOT_DIR/} -> build/$output_file"
  quarto render "$book" --to pdf --output-dir "$BUILD_DIR" --output "$output_file"
done
