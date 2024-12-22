# TexLiveインストール用コンテナ
# cf. https://github.com/Paperist/texlive-ja/blob/main/debian/Dockerfile
FROM ghcr.io/paperist/texlive-ja:debian AS texlive-installer
RUN tlmgr install lualatex-math selnolig # for pandoc lualatex template
RUN tlmgr install pdfjam # 塗り足し用

# メインのコンテナ
FROM mcr.microsoft.com/devcontainers/base:bookworm
WORKDIR /workdir
ENV PATH /usr/local/bin/texlive:$PATH
COPY --from=texlive-installer /usr/local/texlive /usr/local/texlive
RUN ln -sf /usr/local/texlive/*/bin/* /usr/local/bin/texlive

RUN apt-get update
RUN apt-get install -y pandoc fontconfig
