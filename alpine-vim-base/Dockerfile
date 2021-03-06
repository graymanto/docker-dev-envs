FROM alpine-godev-base

MAINTAINER graymanto <graymant@outlook.com>

USER root

# Install vim dependencies
RUN apk --update add \
    bash \
    the_silver_searcher \
    jq \
    ctags \
    curl \
    ncurses-terminfo \
    python \
    python3

# Install vim build dependencies
RUN apk add --update --virtual build-deps \
    build-base \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    make \
    ncurses-dev \
    python3-dev \
    python-dev \
    libice \
    libsm \
    libx11 \
    libxt \
    ncurses

# Build Vim
RUN cd /tmp \
    && git clone https://github.com/vim/vim \
    && cd /tmp/vim \
    && ./configure \
    --disable-gui \
    --disable-netbeans \
    --enable-multibyte \
    --enable-pythoninterp \
	--enable-python3interp=yes \
    --prefix /usr \
    --with-features=huge \
    --with-python-config-dir=/usr/lib/python2.7/config \
    --with-python3-config-dir=/usr/lib/python3.5/config \
    && make install \

# Cleanup
RUN apk del build-deps \
	&& rm -rf /var/cache/*  /var/log/* /var/tmp/*

USER $UNAME

# Start shell
entrypoint ["/bin/zsh"]
