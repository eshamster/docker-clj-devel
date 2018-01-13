FROM clojure:lein-2.8.1-alpine

RUN apk update --no-cache
RUN apk add --no-cache emacs git

# --- install wget with certificate --- #

RUN apk add --no-cache ca-certificates wget openssh && \
    update-ca-certificates

# --- user settings --- #

ARG emacs_home=/root/.emacs.d
ARG site_lisp=${emacs_home}/site-lisp
ARG dev_dir=/root/work

RUN mkdir ${emacs_home} && \
    mkdir ${site_lisp} && \
    mkdir ${dev_dir}

# --- run emacs for installing packages --- #

COPY init.el ${emacs_home}
RUN emacs --batch --load ${emacs_home}/init.el

# --- miscs --- #
WORKDIR /root
