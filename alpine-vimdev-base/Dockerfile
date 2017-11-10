FROM alpine-zsh-base

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
    python3 \

# Install vim build dependencies
	&& apk add --update --virtual build-deps \
    build-base \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    make \
    ncurses-dev \
    python3-dev \
    python-dev \

# Build Vim
	&& cd /tmp \
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
    && apk del build-deps \
    && apk add \
    libice \
    libsm \
    libx11 \
    libxt \
    libstdc++ \
    ncurses \
# Cleanup
	&& rm -rf \
    /var/cache/* \
    /var/log/* \
    /var/tmp/* \
	&& mkdir /var/cache/apk

USER $UNAME

# Start shell
entrypoint ["/bin/zsh"]
