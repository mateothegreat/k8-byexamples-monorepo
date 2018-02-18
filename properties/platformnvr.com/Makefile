include .make/Makefile.inc

HOST	:= platformnvr.com
export

deploy:

	$(MAKE) -C ../../modules/k8-byexamples-wordpress APP=platformnvr-wp 				SERVICE_NAME=platformnvr-wp	SERVICE_PORT=80 install

	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=platformnvr.com 		SERVICE_NAME=platformnvr-wp	SERVICE_PORT=80 issue
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=www.platformnvr.com 	SERVICE_NAME=platformnvr-wp	SERVICE_PORT=80 issue

rollback:

	$(MAKE) -C ../../modules/k8-byexamples-wordpress APP=platformnvr-wp SERVICE_NAME=platformnvr-wp delete

	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=platformnvr.com		revoke
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=www.platformnvr.com	revoke
