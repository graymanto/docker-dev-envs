#! /bin/bash

pushd alpine-dev-base \
	&&  build.sh \
	&& popd \
	&& pushd alpine-dev-base \
	&&  build.sh \
	&& popd \
	&& pushd alpine-go-base \
	&&  build.sh \
	&& popd \
	&& pushd alpine-vim-base \
	&&  build.sh \
	&& popd \
	&& pushd alpine-vim-go-base \
	&&  build.sh \
