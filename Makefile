include .make/Makefile.inc

MODULES		:= 	k8-byexamples-dashboard				\
				k8-byexamples-echoserver				\
				k8-byexamples-elasticsearch-cluster 	\
				k8-byexamples-fluentd-collector		\
				k8-byexamples-gitlab					\
				k8-byexamples-keycloak 				\
				k8-byexamples-kibana 					\
				k8-byexamples-monitoring-grafana 		\
				k8-byexamples-monitoring-prometheus 	\
				k8-byexamples-mysql 					\
				k8-byexamples-openvpn 					\
				k8-byexamples-rabbitmq-cluster 		\
				k8-byexamples-redis 					\
				k8-byexamples-wordpress


init: 				; @git submodule update --init
init-modules: init 	; @for F in $(MODULES); do $(MAKE) init-submodule-$$F; done
init-submodule-%:	; @echo $*; if [ -d modules/$*/.make ]; then cd modules/$* && git submodule update --init; else cd modules/$* && git submodule add -b master git@github.com:mateothegreat/.make.git; fi

clean: 				; rm -rf modules/.make; rm -rf modules/*

commit:  			; @for F in $(MODULES); do cd modules/$* && git add . && git commit -am'$$MESSAGE' && git push; done

## Output list of submodules & repositories
dump: 

	@printf "$(YELLOW)\n%-46s%s\n\n$(BLUE)" "Submodule Name" "Submodule Repository" 
	@for F in $(MODULES); do	printf "%-45s@%s\n" $$F https://github.com/mateothegreat/$$F | sed -e 's/ /./g' -e 's/@/ /' -e 's/-/ /'; done
	@printf "\n"

# dump: $(MODULES)
# $(MODULES):

# 	@printf "%-45s@%s\n" $(@F) https://github.com/mateothegreat/$(@F) | sed -e 's/ /./g' -e 's/@/ /' 
add-%: 			; git submodule add -b master git@github.com:mateothegreat/k8-byexamples-$* modules/k8-byexamples-$*