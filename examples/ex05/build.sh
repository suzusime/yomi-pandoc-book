#!/bin/bash
set -eux

# 変数の定義
SRC_DIR=src
LATEX_SRC_DIR=latex
BUILD_DIR=build
MAIN_LATEX_BASE_NAME=main
PDF_FILE_NAME=main

# Markdown ファイルの一覧を取得
SOURCE_FILE_NAMES=$(perl -le 'for (glob("./src/*.md")) { s!.*/!!; s/\.md$//; print }')

# Markdown から LaTeX への変換
mkdir -p $BUILD_DIR/latex
for file_name in $SOURCE_FILE_NAMES; do
  pandoc -f markdown+east_asian_line_breaks+raw_attribute+multiline_tables -t latex \
    --top-level-division=chapter \
    -o $BUILD_DIR/latex/$file_name.tex \
    $SRC_DIR/$file_name.md
done

# 画像のコピー
mkdir -p $BUILD_DIR/latex/img
cp $SRC_DIR/img/* $BUILD_DIR/latex/img

# LaTeX から PDF への変換
mkdir -p $BUILD_DIR/pdf
cp latex/$MAIN_LATEX_BASE_NAME.tex $BUILD_DIR/latex/$MAIN_LATEX_BASE_NAME.tex
(cd $BUILD_DIR/latex && lualatex $MAIN_LATEX_BASE_NAME.tex)
cp $BUILD_DIR/latex/$MAIN_LATEX_BASE_NAME.pdf $BUILD_DIR/pdf/$PDF_FILE_NAME.pdf
