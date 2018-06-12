#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
#
# https://hub.docker.com/r/zabbix/zabbix-appliance/
#
include .make/Makefile.inc

NS                  		?= default
APP                 		?= icinga2-master
# images
ICINGA2_SERVER_IMAGE		?= "bodsch/docker-icinga2:2.8.4-master"
ICINGA2_WEB_IMAGE			?= "bodsch/docker-icingaweb2:2.5.3"
# icinga2-server
ICINGA2_API_USERS			?= "root:icinga,dashing:dashing,cert:foo-bar"
LOG_LEVEL					?= "debug"
MYSQL_HOST					?= "mysql.devqa.streaming-platform.com"
MYSQL_ROOT_USER				?= "root"
MYSQL_ROOT_PASS				?= "agaeq14"
IDO_PASSWORD				?= "agaeq14"
IDO_DATABASE_NAME			?= "icinga2_master"
# environment variables for the certificates service
ICINGA2_MASTER				?= "icinga2-master"
BASIC_AUTH_USER				?= "admin"
BASIC_AUTH_PASS				?= "admin"
CERT_SERVICE_BA_USER		?= "admin"
CERT_SERVICE_BA_PASSWORD	?= "admin"
CERT_SERVICE_API_USER		?= "root"
CERT_SERVICE_API_PASSWORD	?= "icinga"
CERT_SERVICE_SERVER			?= "icinga2-master"
CERT_SERVICE_PORT			?= "8080"
CERT_SERVICE_PATH			?= "/"
CARBON_HOST					?= ""
CARBON_PORT					?= "2003"
DEMO_DATA					?= "true"
# icinga2-web
ICINGA2_CMD_API_USER		?= "root"
ICINGA2_CMD_API_PASS		?= "icinga"
ICINGAWEB2_USERS			?= "icinga:P@55w0rd!!"
