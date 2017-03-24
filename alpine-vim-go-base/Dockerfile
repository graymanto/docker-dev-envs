FROM alpine-vim-base

MAINTAINER graymanto <graymant@outlook.com>

USER root

# Install vim plugin build dependencies
RUN apk add --update --virtual build-deps \
	build-base \
    cmake \
    llvm \
    python3-dev \
    python-dev \
    perl

USER $UNAME

COPY .vimrc /home/developer/

# Install vundle
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/developer/.vim/bundle/Vundle.vim \
	&& vim +PluginInstall +qall \

# Build YouCompleteMe
RUN cd $UHOME/.vim/bundle/YouCompleteMe \
    && $UHOME/.vim/bundle/YouCompleteMe/install.py --gocode-completer \
# Build vimproc
    && cd $UHOME/.vim/bundle/vimproc.vim \
    && make

# Install go tools
RUN go get -u github.com/alecthomas/gometalinter \
	&& go get -u github.com/nsf/gocode \
	&& go get -u github.com/alecthomas/gometalinter \
	&& go get -u golang.org/x/tools/cmd/goimports \
	&& go get -u golang.org/x/tools/cmd/guru \
	&& go get -u golang.org/x/tools/cmd/gorename \
	&& go get -u github.com/golang/lint/golint \
	&& go get -u github.com/rogpeppe/godef \
	&& go get -u github.com/kisielk/errcheck \
	&& go get -u github.com/jstemmer/gotags \
	&& go get -u github.com/klauspost/asmfmt/cmd/asmfmt \
	&& go get -u github.com/fatih/motion \
	&& go get -u github.com/fatih/gomodifytags \
	&& go get -u github.com/zmb3/gogetdoc \
	&& go get -u github.com/josharian/impl

USER root

# Cleanup
RUN apk del build-deps \
    && rm -rf \
    $UHOME/bundle/YouCompleteMe/third_party/ycmd/clang_includes \
    $UHOME/bundle/YouCompleteMe/third_party/ycmd/cpp \
    /var/cache/* \
    /var/log/* \
    /var/tmp/* \
    && mkdir /var/cache/apk \
    && chown $UID:$GID -R $UHOME

USER $UNAME

# Start shell
entrypoint ["/bin/zsh"]
