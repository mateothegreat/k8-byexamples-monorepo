include .make/Makefile.inc

HOST	:= streamnvr.com
export

deploy:

	$(MAKE) -C ../../modules/k8-byexamples-wordpress APP=streamnvr-wp 					SERVICE_NAME=streamnvr-wp	SERVICE_PORT=80 install 
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=streamnvr.com 		SERVICE_NAME=streamnvr-wp	SERVICE_PORT=80 issue
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=www.streamnvr.com 	SERVICE_NAME=streamnvr-wp	SERVICE_PORT=80 issue

rollback:

	$(MAKE) -C ../../modules/k8-byexamples-wordpress APP=streamnvr-wp SERVICE_NAME=streamnvr-wp delete

	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=streamnvr.com		revoke
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=www.streamnvr.com	revoke
