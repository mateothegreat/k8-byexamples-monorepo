install:

	$(MAKE) -C ../../modules/k8-byexamples-wordpress APP=streaming-platform-wp 					SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=80 install 
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=streaming-platform.com 		SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=80 issue
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=www.streaming-platform.com 	SERVICE_NAME=streaming-platform-wp 	SERVICE_PORT=80 issue

delete:

	$(MAKE) -C ../../modules/k8-byexamples-wordpress APP=streaming-platform-wp SERVICE_NAME=streaming-platform-wp delete
	
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=streaming-platform.com		revoke
	$(MAKE) -C ../../modules/k8-byexamples-ingress-controller HOST=www.streaming-platform.com	revoke
