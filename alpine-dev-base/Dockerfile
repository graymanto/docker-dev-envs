from alpine:latest

MAINTAINER graymanto <graymant@outlook.com>

ENV TERM screen-256color
ENV HOME /home/developer

# Install base packages
RUN apk add --update curl zsh git tmux bash

# Configure environment
ENV UID="1000" \
    UNAME="developer" \
    GID="1000" \
    GNAME="developer" \
    SHELL="/bin/zsh" \
    UHOME=/home/developer

# User
RUN apk --no-cache add sudo \
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
    && echo "${GNAME}:x:${GID}:${UNAME}" \
    >> /etc/group

# Tmux config
COPY tmux.conf /home/developer/.tmux.conf

# Install oh my zsh and themes
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY dev.zsh-theme /home/developer/.oh-my-zsh/themes/

# Install fzf
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
RUN ~/.fzf/install

# Zsh config
COPY .zsh /home/developer/.zsh
RUN rm /home/developer/.zshrc
COPY .zshrc /home/developer/.zshrc

# Final cleaning
RUN rm -rf /var/cache/apk/* \
	&& rm -rf /tmp/* /root/.cache \
	&& rm -rf /home/developer/.zcompdump* \
	&& apk del curl bash

RUN chown -R developer:developer /home/developer

USER $UNAME

# Start shell
entrypoint ["/bin/zsh"]
