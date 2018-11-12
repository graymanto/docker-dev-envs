from node:11.1-alpine

MAINTAINER graymanto <graymant@outlook.com>

ENV TERM screen-256color
ENV HOME /home/developer

# Configure environment
ENV UID="1001" \
    UNAME="developer" \
    GID="1001" \
    GNAME="developer" \
    SHELL="/bin/zsh" \
    UHOME=/home/developer

COPY .vimrc $UHOME/

# Install base packages
RUN apk --no-cache --update add \
	sudo \
    bash \
    the_silver_searcher \
    jq \
    ctags \
    curl \
    ncurses-terminfo \
    python \
    python3 \
    perl \
	build-base \
	git zsh tmux bash \
    libice \
    libsm \
    libx11 \
    libxt \
    libstdc++ \
    ncurses \
    openssh-client \
# Create HOME dir
	&& mkdir -p "${UHOME}" \
	&& chown "${UID}":"${GID}" "${UHOME}" \
# Create user
	&& echo "${UNAME}:x:${UID}:${GID}:${UNAME},,,:${UHOME}:${SHELL}" \
	>> /etc/passwd \
	&& echo "${UNAME}::17032:0:99999:7:::" \
	>> /etc/shadow \
# No password sudo
	&& echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" \
	> "/etc/sudoers.d/${UNAME}" \
	&& chmod 0440 "/etc/sudoers.d/${UNAME}" \
# Create group
	&& echo "${GNAME}:x:${GID}:${UNAME}" >> /etc/group \
# Install oh my zsh
	&& sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install vim build dependencies
RUN apk add --no-cache --update --virtual build-deps \
    libx11-dev \
    libxpm-dev \
    libxt-dev \
    make \
    ncurses-dev \
    python-dev \
    python3-dev \
    cmake \
	&& npm install -g typescript javascript-typescript-langserver flow-language-server \
# Build Vim
	&& cd /tmp \
    && git clone https://github.com/vim/vim \
    && cd /tmp/vim \
    && ./configure \
    --disable-gui \
    --disable-netbeans \
    --enable-multibyte \
	--enable-python3interp=yes \
    --prefix /usr \
    --with-features=huge \
    --with-python3-config-dir=/usr/lib/python3.6/config \
    && make install

# Install vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git $UHOME/.vim/bundle/Vundle.vim \
	&& vim +PluginInstall +qall

# Build YouCompleteMe
RUN cd $UHOME/.vim/bundle/YouCompleteMe \
    && python3 install.py
# Build vimproc
RUN cd $UHOME/.vim/bundle/vimproc.vim \
    && make
# Install lc neovim
RUN cd $UHOME/.vim/bundle/LanguageClient-neovim \
    && ./install.sh

RUN git clone --depth 1 https://github.com/junegunn/fzf.git $UHOME/.fzf \
	&& $UHOME/.fzf/install --bin

# Final cleaning
RUN rm -rf \
		/var/log/* \
		/var/tmp/* \
		$UHOME/bundle/YouCompleteMe/third_party/ycmd/clang_includes \
		$UHOME/bundle/YouCompleteMe/third_party/ycmd/cpp \
		$UHOME/.vim/bundle/YouCompleteMe/.git \
		$UHOME/.vim/bundle/LanguageClient-neovim/.git \
		/tmp/* /root/.cache \
		$UHOME/.zcompdump* \
		&& apk del bash build-deps

USER $UNAME

# Tmux config
COPY .tmux.conf $UHOME/.tmux.conf
COPY .fzf.zsh $UHOME/.fzf.zsh
# Install oh my zsh and themes
COPY dev.zsh-theme $UHOME/.oh-my-zsh/themes/

# Zsh config
COPY .zsh $UHOME/.zsh
RUN rm $UHOME/.zshrc
COPY .zshrc $UHOME/.zshrc

COPY .agignore $UHOME/.agignore
COPY .gitconfig $UHOME/.gitconfig
COPY .gitignore_global $UHOME/.gitignore_global

RUN chown $UID:$GID -R $UHOME

# Start shell
entrypoint ["/bin/zsh"]
