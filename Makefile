include .make/Makefile.inc

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

init: 				; @git submodule update --init
init-modules: init 	; @for F in $(MODULES); do $(MAKE) init-submodule-$$F; done
init-submodule-%:	; @echo $*; if [ -d modules/$*/.make ]; then cd modules/$* && git submodule update --init; else cd modules/$* && git submodule add -b master git@github.com:mateothegreat/.make.git; fi

backup: 			; @echo $(TIME); tar -czf ../.backup/modules.$(TIME).tar .
clean: 	backup		; rm -rf modules/.make; rm -rf modules/*
commit: backup		; @for F in $(MODULES); do cd $(PWD)/modules/$$F && git add . && git commit -am'$$MESSAGE' && git push origin HEAD:master; done

## Output list of submodules & repositories
dump: 

	@printf "$(YELLOW)\n%-46s%s\n\n$(BLUE)" "Submodule Name" "Submodule Repository" 
	@for F in $(MODULES); do	printf "%-45s@%s\n" $$F https://github.com/mateothegreat/$$F | sed -e 's/ /./g' -e 's/@/ /' -e 's/-/ /'; done
	@printf "\n"

# dump: $(MODULES)
# $(MODULES):

# 	@printf "%-45s@%s\n" $(@F) https://github.com/mateothegreat/$(@F) | sed -e 's/ /./g' -e 's/@/ /' 
add-%: 			; git submodule add -b master git@github.com:mateothegreat/k8-byexamples-$* modules/k8-byexamples-$*; cd modules/k8-byexamples-$* && git submodule update --init

streaming-platform/wordpress/install:

	$(MAKE) -C modules/k8-byexamples-wordpress APP=streaming-platform-wp 				SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=8001 install 
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=streaming-platform.com 	SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=8001 issue
	$(MAKE) -C modules/k8-byexamples-ingress-controller HOST=www.streaming-platform.com SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=8001 issue

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
