```sh
# Markdown -> LaTeX
pandoc -f markdown -t latex --pdf-engine=lualatex -o ch01.tex ch01.md

# LaTeX -> PDF
lualatex main.tex
```
