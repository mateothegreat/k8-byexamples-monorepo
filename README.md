<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Complete cluster built with k8-byexamples

> k8 by example -- straight to the point, simple execution.

# Getting started
Clone this repo using --recurse-submodules to automatically checkout the submodules for you.

# Including the .make "library"

You can include this in a git repo as a submodule (preferred) or use an environment variable.

## Add .make as a submodule

```sh
$ git submodule add https://github.com/mateothegreat/.make
```

### Use an enviroment variable

```sh
export MAKE_INCLUDE=/workspace/k8/cluster-2/.make
```

Now you can simply reference this path in any of your `Makfile`'s

```Makefile
include $(MAKE_INCLUDE)/Makefile.inc
```
