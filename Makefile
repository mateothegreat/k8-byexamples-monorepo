include .make/Makefile.inc

# MODULES := $(shell )
MODULES_INSTALLS := $(shell grep -v "\#" modules.config)

CLUSTER		?= cluster-6
NS			:= default

install/modules: ; @echo; for F in $(MODULES_INSTALLS); do echo "[ INSTALLING $$F ]: " | tr 'a-z' 'A-Z' ; $(MAKE) -C modules/$$F install; echo; done; echo;


install/igress:

	# Pre-requisites
	$(MAKE) -C modules/k8-byexamples-cert-manager install
	$(MAKE) -C modules/k8-byexamples-ingress-controller install LOADBALANCER_IP=35.193.138.211

install/certs:

	$(MAKE) -C modules/k8-byexamples-ingress-controller issue 	HOST=elasticsearch.monitoring.streaming-platform.com 	SERVICE_NAME=elasticsearch 	SERVICE_PORT=9200
	$(MAKE) -C modules/k8-byexamples-ingress-controller issue 	HOST=kibana.monitoring.streaming-platform.com 			SERVICE_NAME=kibana 		SERVICE_PORT=80
	$(MAKE) -C modules/k8-byexamples-ingress-controller issue 	HOST=grafana.monitoring.streaming-platform.com 			SERVICE_NAME=grafana 		SERVICE_PORT=80
	$(MAKE) -C modules/k8-byexamples-ingress-controller revoke 	HOST=zabbix.monitoring.streaming-platform.com 			SERVICE_NAME=zabbix-web		SERVICE_PORT=80
	$(MAKE) -C modules/k8-byexamples-ingress-controller issue 	HOST=icinga.monitoring.streaming-platform.com 			SERVICE_NAME=icinga2-web	SERVICE_PORT=80

install/test:

	$(MAKE) -C modules/k8-byexamples-nginx install
	$(MAKE) -C modules/k8-byexamples-ingress-controller issue 	HOST=test.monitoring.streaming-platform.com 	SERVICE_NAME=nginx 		SERVICE_PORT=80

01_vpn: 

	$(MAKE) -C modules/k8-byexamples-openvpn clean CN=vpn.streaming-platform.com
	$(MAKE) -C modules/k8-byexamples-openvpn deploy CN=vpn.streaming-platform.com REMOTE_TAG=docker.io/appsoa/docker-alpine-openvpn DNS=10.11.240.10 PODS_SUBNET="10.8.0.0 255.255.0.0" SERVICES_SUBNET="10.11.0.0 255.255.0.0"
	$(MAKE) -C modules/k8-byexamples-openvpn issue-cert CN=vpn.streaming-platform.com NAME=$(CLUSTER)-cert-1
	$(MAKE) -C modules/k8-byexamples-openvpn resolv-conf CN=vpn.streaming-platform.com DNS=10.11.240.10

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
	$(MAKE) -C modules/k8-byexamples-ingress-controller install LOADBALANCER_IP=35.224.39.104

04_deploy_wordpress_properties:

	# Setup wordpress sites
	$(MAKE) -C properties deploy
	$(MAKE) -C properties tests

#
#
#
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

commit:

	-git add . && git commit -am'bump' && git push
	-cd .make && git add . && git commit -am'bump' && git push
	$(MAKE) git/.make-up