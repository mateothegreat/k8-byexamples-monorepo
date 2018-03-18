<!--
#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#-->

# Makefile support

> k8 by example -- straight to the point, simple execution.

```
                   _        _                        _      _     
  _ __    __ _    | |__    (_)    _ _       o O O   (_)    | |_   
 | '  \  / _` |   | / /    | |   | ' \     o        | |    |  _|  
 |_|_|_| \__,_|   |_\_\   _|_|_  |_||_|   TS__[O]  _|_|_   _\__|  
_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| {======|_|"""""|_|"""""| 
"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-' 

```
[![Clickity click](https://img.shields.io/badge/k8s%20by%20example%20yo-limit%20time-ff69b4.svg?style=flat-square)](https://k8.matthewdavis.io)
[![Twitter Follow](https://img.shields.io/twitter/follow/yomateod.svg?label=Follow&style=flat-square)](https://twitter.com/yomateod) [![Skype Contact](https://img.shields.io/badge/skype%20id-appsoa-blue.svg?style=flat-square)](skype:appsoa?chat)

# Usage
```sh
$ make help

                                __                 __
   __  ______  ____ ___  ____ _/ /____  ____  ____/ /
  / / / / __ \/ __  __ \/ __  / __/ _ \/ __ \/ __  /
 / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
 \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
/____
                        yomateo.io, it ain't easy.

Usage: make <target(s)>

Targets:

  dump/submodules      Output list of submodules & repositories
  install              Installs manifests to kubernetes using kubectl apply (make manifests to see what will be installed)
  delete               Deletes manifests to kubernetes using kubectl delete (make manifests to see what will be installed)
  get                  Retrieves manifests to kubernetes using kubectl get (make manifests to see what will be installed)
  describe             Describes manifests to kubernetes using kubectl describe (make manifests to see what will be installed)
  context              Globally set the current-context (default namespace)
  shell                Grab a shell in a running container
  dump/logs            Find first pod and follow log output
  dump/manifests       Output manifests detected (used with make install, delete, get, describe, etc)


Tools:

  git/update            Update submodule(s) to HEAD from origin
  rbac/grant            Create clusterrolebinding for cluster-admin
  testing-curl          Try to curl http & https from $(HOST)
  testing/curlhttp      Try to curl http://$(HOST)
  testing/curlhttps     Try to curl https://$(HOST)
  testing/getip         Retrieve external IP from api.ipify.org

```

# Incude .make as a library

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

# Incude .make as a library

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
