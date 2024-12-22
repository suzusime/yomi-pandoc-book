## シェルスクリプト版

```sh
# PDFファイルの作成
./build.sh

# 作成したファイルの削除
./clean.sh
```

## Taskfile版

```sh
# PDFファイルの作成
task build

# 作成したファイルの削除
task clean
```

なお、Taskfileを使う場合は、`.devcontainer/Dcokerfile`にTaskfileのインストール処理を書く必要があります。
以下の「Go系ツールインストール用コンテナ」部分と `COPY --from=golang /go/bin/task /usr/local/bin/task` が追加する部分です。

```dockerfile
# Dockerfile

# TexLiveインストール用コンテナ
# cf. https://github.com/Paperist/texlive-ja/blob/main/debian/Dockerfile
FROM ghcr.io/paperist/texlive-ja:debian AS texlive-installer
RUN tlmgr install \
      lualatex-math selnolig # for pandoc lualatex template

# Go系ツールインストール用コンテナ
FROM golang:1.23-bookworm AS golang
RUN go install github.com/go-task/task/v3/cmd/task@latest

# メインのコンテナ
FROM mcr.microsoft.com/devcontainers/base:bookworm
WORKDIR /workdir
ENV PATH /usr/local/bin/texlive:$PATH
COPY --from=texlive-installer /usr/local/texlive /usr/local/texlive
COPY --from=golang /go/bin/task /usr/local/bin/task
RUN ln -sf /usr/local/texlive/*/bin/* /usr/local/bin/texlive

RUN apt-get update
RUN apt-get install -y pandoc fontconfig
```