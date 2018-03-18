MANIFESTS 	:= $(shell find manifests -type f 2> /dev/null | tr '\r\n' ' ')
export

.PHONY: manifests kube logs

## Installs manifests to kubernetes using kubectl apply (make manifests to see what will be installed)
install:	; @echo; for F in $(MANIFESTS); do echo -n "[ $(BLUE)INSTALLING $$F$(RESET) ]: " | tr 'a-z' 'A-Z' ; envsubst < $$F | kubectl -n $$NS apply -f -; done; echo;

## Deletes manifests to kubernetes using kubectl delete (make manifests to see what will be installed)
delete:		; @echo; for F in $(MANIFESTS); do echo -n "[ $(GREEN)DELETING $$F$(RESET) ]: " | tr 'a-z' 'A-Z' ; envsubst < $$F | kubectl -n $$NS delete --ignore-not-found -f -; done; echo;

## Retrieves manifests to kubernetes using kubectl get (make manifests to see what will be installed)
get:		; @echo; for F in $(MANIFESTS); do echo "\n[ $(GREEN)RETRIEVING $$F$(RESET) ]: \n" | tr 'a-z' 'A-Z' ; envsubst < $$F | kubectl -n $$NS get -f -; done; echo;

## Retrives all resources (in color!)
get/all:

	@echo "$(GREEN)"
	@kubectl get pod -o wide --all-namespaces

	@echo "$(YELLOW)"
	@kubectl get svc -o wide --all-namespaces

	@echo "$(WHITE)"
	@kubectl get ing,pvc -o wide --all-namespaces

	@echo "$(NORMAL)"
	@kubectl get deployment,rs,rc  --all-namespaces

## Describes manifests to kubernetes using kubectl describe (make manifests to see what will be installed)
describe:	; @echo; for F in $(MANIFESTS); do echo "\n[ $(GREEN)DESCRIBING $$F$(RESET) ]: \n" | tr 'a-z' 'A-Z' ; envsubst < $$F | kubectl -n $$NS describe -f -; done; echo;

## Globally set the current-context (default namespace)
context:    ; kubectl config set-context $(kubectl config current-context) --namespace=$(NS)

## Grab a shell in a running container
shell:      ; kubectl exec $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}') -it -- /bin/sh

## Find first pod and follow log output
dump/logs: 	; kubectl --namespace $(NS) logs -f $(shell kubectl get pods --all-namespaces -lapp=$(APP) -o jsonpath='{.items[0].metadata.name}')

## Output manifests detected (used with make install, delete, get, describe, etc)
dump/manifests: ; @echo "MANIFESTS DETECTED: " $(MANIFESTS)

### Create clusterrolebinding for cluster-admin
rbac/grant-google:

	kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user=$(gcloud info | grep Account | cut -d '[' -f 2 | cut -d ']' -f 1)