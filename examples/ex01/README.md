```sh
# Markdown -> LaTeX
$ pandoc -f markdown -t latex --standalone --pdf-engine=lualatex -V documentclass=jlreq -o main.tex main.md

# LaTeX -> PDF
$ lualatex main.tex
```
