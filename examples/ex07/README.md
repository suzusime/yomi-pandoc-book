## シェルスクリプト版

```sh
# PDFファイルの作成
./build.sh

# 作成したファイルの削除
./clean.sh
```

## 抽象構文木(AST)の確認
```sh
# 抽象構文木を出力
pandoc -f markdown -t native src/ch01.md

# 抽象構文木を出力（日本語をそのまま表示する）
pandoc -f markdown -t native src/ch01.md | perl -CSD -pe 's/\\(\d{3,6})/chr($1)/ge'

# 抽象構文木を出力(JSON形式)
pandoc -f markdown -t json src/ch01.md
```
