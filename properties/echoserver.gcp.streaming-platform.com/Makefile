include .make/Makefile.inc

HOST	:= echoserver.gcp.streaming-platform.com
export

deploy:

	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=echoserver.gcp.streaming-platform.com 	SERVICE_NAME=echoserver 	SERVICE_PORT=8080 issue

rollback:


	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=echoserver.gcp.streaming-platform.com	revoke
