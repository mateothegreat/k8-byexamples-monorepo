#                                 __                 __
#    __  ______  ____ ___  ____ _/ /____  ____  ____/ /
#   / / / / __ \/ __ `__ \/ __ `/ __/ _ \/ __ \/ __  /
#  / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /
#  \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/
# /____                     matthewdavis.io, holla!
#
include .make/Makefile.inc

NS                  ?= default
APP                 ?= atlassian-confluence
MYSQL_HOST		    ?= mysql
MYSQL_DATABASE      ?= confluence
MYSQL_USER          ?= confluence
MYSQL_PASSWORD      ?= confluence
export


install: 	guard-APP initdb 
delete:		guard-APP dropdb

## Create mysql database & grant (DROP DATABASE is performed!)
initdb:	

	mysql -h $(MYSQL_HOST) -uroot -pmysql -e "CREATE DATABASE IF NOT EXISTS \`$(MYSQL_DATABASE)\`"
	mysql -h $(MYSQL_HOST) -uroot -pmysql -e "GRANT ALL PRIVILEGES ON \`$(MYSQL_DATABASE)\`.* TO '$(MYSQL_USER)'@'10.%' IDENTIFIED BY '$(MYSQL_PASSWORD)'"

dropdb: ; mysql -h $(MYSQL_HOST) -uroot -pmysql -e "DROP DATABASE IF EXISTS \`$(MYSQL_DATABASE)\`" | true