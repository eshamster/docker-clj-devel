# Dockerfile: clj-devel

A Dockerfile to configure Clojure development environment with Emacs.

## Installation

```bash
$ docker pull eshamster/clj-devel
$ docker run -v <a host folder>:/root/work -it eshamster/clj-devel /bin/sh
```

## Description

This mainly consists of ...

- Based on the official image of Clojure on Alpine Linux
- Emacs 25 with cider

---------

## Author

eshamster (hamgoostar@gmail.com)

## Copyright

Copyright (c) 2017 eshamster (hamgoostar@gmail.com)

## License

Distributed under the MIT License
