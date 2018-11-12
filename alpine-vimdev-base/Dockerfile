FROM alpine-zsh-base

MAINTAINER graymanto <graymant@outlook.com>

USER root

# Install vim dependencies
RUN apk --no-cache --update add \
    ctags \
    ncurses-terminfo \
    python \
    python3 \
    libice \
    libsm \
    libx11 \
    libxt \
    libstdc++ \
    ncurses

# Install vim build dependencies
	&& apk add --no-cache --update --virtual build-deps \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
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
# Cleanup
    && apk del build-deps \
	&& rm -rf \
    /var/cache/* \
    /var/log/* \
    /var/tmp/* \
	&& mkdir /var/cache/apk

USER $UNAME

# Start shell
entrypoint ["/bin/zsh"]
