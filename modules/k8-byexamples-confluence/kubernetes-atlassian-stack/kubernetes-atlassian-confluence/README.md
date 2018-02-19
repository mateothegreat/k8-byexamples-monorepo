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

# Kubernetes MySQL backed by PersistentVolumeClaim

> k8 by example -- straight to the point, simple execution.

## Usage

```sh
$ make help

Usage:

  make <target>

Targets:

  logs                 Find first pod and follow log output
  manifests            Output manifests detected (used with make install, delete, get, describe, etc)
  install              Installs manifests to kubernetes using kubectl apply (make manifests to see what will be installed)
  delete               Deletes manifests to kubernetes using kubectl delete (make manifests to see what will be installed)
  get                  Retrieves manifests to kubernetes using kubectl get (make manifests to see what will be installed)
  describe             Describes manifests to kubernetes using kubectl describe (make manifests to see what will be installed)
```

## Install

```sh
$ make install

[ DEPLOYING manifests/deployment.yaml ]: deployment "atlassian-confluence" created
[ DEPLOYING manifests/persistentvolumeclaim.yaml ]: persistentvolumeclaim "atlassian-confluence-persistent-storage" created
[ DEPLOYING manifests/service.yaml ]: service "atlassian-confluence" created

```

## Logs

```sh
$ make logs
...
2018-02-09 18:10:04 1 [Note] InnoDB: 5.6.39 started; log sequence number 1625997
2018-02-09 18:10:04 1 [Note] Server hostname (bind-address): '*'; port: 3306
2018-02-09 18:10:04 1 [Note] IPv6 is available.
2018-02-09 18:10:04 1 [Note]   - '::' resolves to '::';
2018-02-09 18:10:04 1 [Note] Server socket created on IP: '::'.
2018-02-09 18:10:04 1 [Warning] 'proxies_priv' entry '@ root@mysql-5966fc6745-6mst8' ignored in --skip-name-resolve mode.
2018-02-09 18:10:04 1 [Note] Event Scheduler: Loaded 0 events
2018-02-09 18:10:04 1 [Note] mysqld: ready for connections.
...
```

## Testing

Using dns, mysql points to the service (see setting up openvpn: https://github.com/mateothegreat/k8-byexamples-openvpn)

```sh
$ mysql -h mysql -uroot -pmysql
mysql: [Warning] Using a password on the command line interface can be insecure.
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 2
Server version: 5.6.39 MySQL Community Server (GPL)

Copyright (c) 2000, 2018, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> show databases;
+---------------------+
| Database            |
+---------------------+
| information_schema  |
| keycloak            |
| #mysql50#lost+found |
| mysql               |
| performance_schema  |
+---------------------+
5 rows in set (0.04 sec)
```

## Delete

```sh
$ make delete

[ DELETING MANIFESTS/DEPLOYMENT.YAML ]: deployment "mysql" deleted
[ DELETING MANIFESTS/PERSISTENTVOLUMECLAIM.YAML ]: persistentvolumeclaim "mysql" deleted
[ DELETING MANIFESTS/SERVICE.YAML ]: service "mysql" deleted
```
