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

```
                   _        _                        _      _     
  _ __    __ _    | |__    (_)    _ _       o O O   (_)    | |_   
 | '  \  / _` |   | / /    | |   | ' \     o        | |    |  _|  
 |_|_|_| \__,_|   |_\_\   _|_|_  |_||_|   TS__[O]  _|_|_   _\__|  
_|"""""|_|"""""|_|"""""|_|"""""|_|"""""| {======|_|"""""|_|"""""| 
"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'"`-0-0-'./o--000'"`-0-0-'"`-0-0-' 


                            (╯°□°）╯︵ ┻━┻
                                      ɯןǝɥ
```
> k8 by example -- straight to the point, simple execution.

# Getting started
Clone this repo using --recurse-submodules to automatically checkout the submodules for you.

```
yomateod@DESKTOP-SR72DSK:/mnt/c/workspace/k8/k8-cluster-starter$ make dump/submodules

Submodule Name                                Submodule Repository

k8 byexamples-cert-manager........... https://github.com/mateothegreat/k8-byexamples-cert-manager
k8 byexamples-dashboard.............. https://github.com/mateothegreat/k8-byexamples-dashboard
k8 byexamples-echoserver............. https://github.com/mateothegreat/k8-byexamples-echoserver
k8 byexamples-elasticsearch-cluster.. https://github.com/mateothegreat/k8-byexamples-elasticsearch-cluster
k8 byexamples-fluentd-collector...... https://github.com/mateothegreat/k8-byexamples-fluentd-collector
k8 byexamples-gitlab................. https://github.com/mateothegreat/k8-byexamples-gitlab
k8 byexamples-gluu................... https://github.com/mateothegreat/k8-byexamples-gluu
k8 byexamples-google-ingressing...... https://github.com/mateothegreat/k8-byexamples-google-ingressing
k8 byexamples-guacamole.............. https://github.com/mateothegreat/k8-byexamples-guacamole
k8 byexamples-haproxy................ https://github.com/mateothegreat/k8-byexamples-haproxy
k8 byexamples-influxdb............... https://github.com/mateothegreat/k8-byexamples-influxdb
k8 byexamples-jenkins................ https://github.com/mateothegreat/k8-byexamples-jenkins
k8 byexamples-keycloak............... https://github.com/mateothegreat/k8-byexamples-keycloak
k8 byexamples-keycloak-proxy......... https://github.com/mateothegreat/k8-byexamples-keycloak-proxy
k8 byexamples-kibana................. https://github.com/mateothegreat/k8-byexamples-kibana
k8 byexamples-minio.................. https://github.com/mateothegreat/k8-byexamples-minio
k8 byexamples-monitoring-grafana..... https://github.com/mateothegreat/k8-byexamples-monitoring-grafana
k8 byexamples-monitoring-metricbeat.. https://github.com/mateothegreat/k8-byexamples-monitoring-metricbeat
k8 byexamples-monitoring-prometheus.. https://github.com/mateothegreat/k8-byexamples-monitoring-prometheus
k8 byexamples-mysql.................. https://github.com/mateothegreat/k8-byexamples-mysql
k8 byexamples-openvpn................ https://github.com/mateothegreat/k8-byexamples-openvpn
k8 byexamples-postgresql............. https://github.com/mateothegreat/k8-byexamples-postgresql
k8 byexamples-rabbitmq-cluster....... https://github.com/mateothegreat/k8-byexamples-rabbitmq-cluster
k8 byexamples-redis.................. https://github.com/mateothegreat/k8-byexamples-redis
k8 byexamples-wordpress.............. https://github.com/mateothegreat/k8-byexamples-wordpress
k8 byexamples-zipkin................. https://github.com/mateothegreat/k8-byexamples-zipkin
```

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
