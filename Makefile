include .make/Makefile.inc

CLUSTER		?= cluster-6
NS			:= default
TIME		:= $(shell date +"%Y-%m-%d_%H%M%S")
MODULES		:= 	k8-byexamples-dashboard					\
				k8-byexamples-ingress-controller		\
				k8-byexamples-echoserver				\
				k8-byexamples-elasticsearch-cluster 	\
				k8-byexamples-fluentd-collector			\
				k8-byexamples-gitlab					\
				k8-byexamples-keycloak 					\
				k8-byexamples-kibana 					\
				k8-byexamples-monitoring-grafana 		\
				k8-byexamples-monitoring-prometheus 	\
				k8-byexamples-mysql 					\
				k8-byexamples-openvpn 					\
				k8-byexamples-rabbitmq-cluster 			\
				k8-byexamples-redis 					\
				k8-byexamples-wordpress
export

01_vpn: setup/prerequisites

	$(MAKE) -C modules/k8-byexamples-openvpn clean CN=vpn.streaming-platform.com
	$(MAKE) -C modules/k8-byexamples-openvpn deploy CN=vpn.streaming-platform.com REMOTE_TAG=docker.io/appsoa/docker-alpine-openvpn DNS=10.11.240.10 PODS_SUBNET="10.11.0.0 255.255.0.0" SERVICES_SUBNET="10.11.0.0 255.255.0.0"
	$(MAKE) -C modules/k8-byexamples-openvpn issue-cert CN=vpn.streaming-platform.com NAME=$(CLUSTER)-cert-1
	$(MAKE) -C modules/k8-byexamples-openvpn resolv-conf CN=vpn.streaming-platform.com DNS=10.11.240.10

	sleep 5

	nslookup openvpn

02_install_backend_services: 

	$(MAKE) -C modules/k8-byexamples-echoserver install
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=echoserver.gcp.streaming-platform.com revoke

	$(MAKE) -C modules/k8-byexamples-mysql install
	
	sleep 5

	$(MAKE) -C modules/k8-byexamples-keycloak install

	sleep 5

	nslookup mysql
	nslookup keycloak

	mysql -h mysql -uroot -pmysql -e "SHOW DATABASES"

03_install_ingress_resources:

	# Pre-requisites
	$(MAKE) -C modules/k8-byexamples-cert-manager install
	$(MAKE) -C modules/k8-byexamples-ingress-controller install LOADBALANCER_IP=35.224.16.183

04_deploy_wordpress_properties:

	# Setup wordpress sites
	$(MAKE) -C properties deploy
	$(MAKE) -C properties tests

#
#
#

## Output list of submodules & repositories
dump: 

	@printf "$(YELLOW)\n%-46s%s\n\n$(BLUE)" "Submodule Name" "Submodule Repository" 
	@for F in $(MODULES); do	printf "%-45s@%s\n" $$F https://github.com/mateothegreat/$$F | sed -e 's/ /./g' -e 's/@/ /' -e 's/-/ /'; done
	@printf "\n"

setup/cluster:

	gcloud alpha container 	--project "streaming-platform-devqa" 	\
							clusters create "$(CLUSTER)"			\
							--zone "us-central1-a" 					\
							--username "admin" 						\
							--cluster-version "1.9.2-gke.1" 		\
							--machine-type "n1-standard-2" 			\
							--image-type "UBUNTU"					\
							--disk-size "100" 						\
							--scopes "https://www.googleapis.com/auth/dns","https://www.googleapis.com/auth/compute","https://www.googleapis.com/auth/devstorage.read_only","https://www.googleapis.com/auth/logging.write","https://www.googleapis.com/auth/monitoring","https://www.googleapis.com/auth/servicecontrol","https://www.googleapis.com/auth/service.management.readonly","https://www.googleapis.com/auth/trace.append" \
							--num-nodes "2" 						\
							--network "vpc-01-devqa" 				\`
							--enable-cloud-logging 					\
							--enable-cloud-monitoring 				\
							--cluster-ipv4-cidr "10.11.0.0/16" 		\
							--subnetwork "private-internal" 		\

	gcloud container clusters get-credentials $(CLUSTER)

## Create cluster-admin-binding for current gcloud user
setup/grant:

	kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info | grep Account | cut -d '[' -f 2 | cut -d ']' -f 1) | true

setup/prerequisites: setup/grant

	# Pre-requisites
	$(MAKE) -C modules/k8-byexamples-cert-manager install
	$(MAKE) -C modules/k8-byexamples-ingress-controller install LOADBALANCER_IP=35.224.16.183

ingress/install: setup/prerequisites

	# Pre-requisites
	$(MAKE) -C modules/k8-byexamples-cert-manager install
	$(MAKE) -C modules/k8-byexamples-ingress-controller install



ingress/remove:

	$(MAKE) -C modules/k8-byexamples-cert-manager delete
	$(MAKE) -C modules/k8-byexamples-ingress-controller delete


streaming-platform/wordpress/delete:

	$(MAKE) -C modules/k8-byexamples-wordpress APP=streaming-platform-wp delete
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=streaming-platform.com		revoke
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.streaming-platform.com	revoke

streamnvr/wordpress/install:

	$(MAKE) -C modules/k8-byexamples-wordpress APP=streamnvr-wp 						SERVICE_NAME=streamnvr-wp 			SERVICE_PORT=8002 install 
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=streamnvr.com 				SERVICE_NAME=streamnvr-wp 			SERVICE_PORT=8002 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.streamnvr.com 			SERVICE_NAME=streamnvr-wp 			SERVICE_PORT=8002 issue


platformnvr/wordpress/install:

	$(MAKE) -C modules/k8-byexamples-wordpress APP=platformnvr-wp 						SERVICE_NAME=platformnvr-wp 		SERVICE_PORT=8003 install
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=platformnvr.com 			SERVICE_NAME=platformnvr-wp 		SERVICE_PORT=8003 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.platformnvr.com 		SERVICE_NAME=platformnvr-wp 		SERVICE_PORT=8003 issue


wordpress/install:

	$(MAKE) -C modules/k8-byexamples-wordpress APP=streaming-platform-wp 				SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=8001 install 
	$(MAKE) -C modules/k8-byexamples-wordpress APP=streamnvr-wp 						SERVICE_NAME=streamnvr-wp 			SERVICE_PORT=8002 install 
	$(MAKE) -C modules/k8-byexamples-wordpress APP=platformnvr-wp 						SERVICE_NAME=platformnvr-wp 		SERVICE_PORT=8003 install

	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=streaming-platform.com 	SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=8001 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.streaming-platform.com SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=8001 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=streamnvr.com 				SERVICE_NAME=streamnvr-wp 			SERVICE_PORT=8002 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.streamnvr.com 			SERVICE_NAME=streamnvr-wp 			SERVICE_PORT=8002 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=platformnvr.com 			SERVICE_NAME=platformnvr-wp 		SERVICE_PORT=8003 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.platformnvr.com 		SERVICE_NAME=platformnvr-wp 		SERVICE_PORT=8003 issue

wordpress/delete:

	$(MAKE) -C modules/k8-byexamples-wordpress APP=streaming-platform-wp 				delete
	$(MAKE) -C modules/k8-byexamples-wordpress APP=streamnvr-wp 						delete
	$(MAKE) -C modules/k8-byexamples-wordpress APP=platformnvr-wp 						delete

	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=streaming-platform.com		revoke
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.streaming-platform.com	revoke
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=streamnvr.com				revoke
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.streamnvr.com			revoke
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=platformnvr.com			revoke
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.platformnvr.com		revoke

testing/install:

	$(MAKE) -C modules/k8-byexamples-echoserver install
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=echoserver.gcp.streaming-platform.com revoke


# dump: $(MODULES)
# $(MODULES):

# 	@printf "%-45s@%s\n" $(@F) https://github.com/mateothegreat/$(@F) | sed -e 's/ /./g' -e 's/@/ /' 
add-%: 			; git submodule add -b master git@github.com:mateothegreat/k8-byexamples-$* modules/k8-byexamples-$*; cd modules/k8-byexamples-$* ; git submodule update --init

init: 				; @git submodule update --init
init-modules: init 	; @for F in $(MODULES); do $(MAKE) init-submodule-$$F; done
init-submodule-%:	; @echo $*; if [ -d modules/$*/.make ]; then cd modules/$* && git submodule update --init; else cd modules/$* && git submodule add -b master git@github.com:mateothegreat/.make.git; fi

backup: 			; @echo $(TIME); tar -czf ../.backup/modules.$(TIME).tar .
clean: 	backup		; rm -rf modules/.make; rm -rf modules/*
commit: backup		; @for F in $(MODULES); do cd $(PWD)/modules/$$F && git add . && git commit -am'$$MESSAGE' && git push origin HEAD:master; done
