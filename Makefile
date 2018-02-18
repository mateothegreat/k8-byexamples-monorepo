include .make/Makefile.inc

add-%:

	git submodule add -b master git@github.com:mateothegreat/k8-byexamples-$* modules/k8-byexamples-$*

init-modules: 	init-k8-byexamples-dashboard				\
				init-k8-byexamples-echoserver				\
				init-k8-byexamples-elasticsearch-cluster 	\
				init-k8-byexamples-fluentd-collector		\
				init-k8-byexamples-gitlab					\
				init-k8-byexamples-keycloak 				\
				init-k8-byexamples-kibana 					\
				init-k8-byexamples-monitoring-grafana 		\
				init-k8-byexamples-monitoring-prometheus 	\
				init-k8-byexamples-mysql 					\
				init-k8-byexamples-openvpn 					\
				init-k8-byexamples-rabbitmq-cluster 		\
				init-k8-byexamples-redis 					\
				init-k8-byexamples-wordpress

	# git submodule foreach 'git fetch origin; git checkout master; git reset --hard origin/master; git submodule update --recursive; git clean -dfx'
init: ;	git submodule update --init

init-%:

	if [ -d modules/$*/.make ]; then cd modules/$* && git submodule update --init; else cd modules/$* && git submodule add -b master git@github.com:mateothegreat/.make.git; fi

clean:

	rm -rf modules/.make
	rm -rf modules/*