# Docker Development Environments

This is a work in progress repository to create complete development environments in docker for various languages.

The idea is to be relatively space efficient by building each language on top of a common base.

Each environment contains the development tools for the language, zsh and a copy of vim complete with plugins for editing files within the container.

## Is This Useful For Me?

In it's current form probably not as the environments are heavily customised for my own personal development setup. It's mostly shared here for inspiration to allow people to copy and create their own development setup.

## Build

Currently a build script is provided for creating a development environment for golang.

From the root of the repository run:

```bash
./build_vimgobase.sh
```

This should create a docker image named alpine-vim-go-base.

## Example Usage

```bash
docker run -ti --rm -v /Users/me/MySourceCode:/home/developer/workspace/src alpine-vim-go-base
```