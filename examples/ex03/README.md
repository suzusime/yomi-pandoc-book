```sh
# Markdown -> LaTeX
pandoc -f markdown+east_asian_line_breaks+raw_attribute+multiline_tables \
  -t latex --pdf-engine=lualatex \
  --top-level-division=chapter \
  -o ch01.tex ch01.md

# LaTeX -> PDF
lualatex main.tex
```
