MODULES 	:= $(shell find modules -mindepth 1 -maxdepth 1 -type d 2> /dev/null 2> /dev/null | tr '\r\n' ' ')
export

.PHONY: help h
.DEFAULT_GOAL := help

help:


	@echo "${PURPLE}"
	@echo "                                __                 __"
	@echo "   __  ______  ____ ___  ____ _/ /____  ____  ____/ /"
	@echo "  / / / / __ \/ __  __ \/ __  / __/ _ \/ __ \/ __  / "
	@echo " / /_/ / /_/ / / / / / / /_/ / /_/  __/ /_/ / /_/ /  "
	@echo " \__, /\____/_/ /_/ /_/\__,_/\__/\___/\____/\__,_/   "
	@echo "/____                                                "
	@echo "                       ${BLUE} yomateo.io, it ain't easy.   "
	@echo "${RESET}"
	@echo "Usage: ${YELLOW}make${RESET} ${GREEN}<target(s)>${RESET}"
	@echo
	@echo Targets:
	@echo
	@awk '/^[a-zA-Z\/\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${GREEN}%-20s${RESET} ${GRAY}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo
	@echo
	@echo Tools:
	@echo
	@awk '/^[a-zA-Z\/\-\_0-9]+:/ { \
		helpMessage = match(lastLine, /^### (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")-1); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf "  ${GREEN}%-20s${RESET} ${GRAY}%s${RESET}\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
	@echo

guard-%:
	@ if [ "${${*}}" = "" ]; then \
		echo "Environment variable $* not set (make $*=.. target or export $*=.."; \
		exit 1; \
	fi

### Get your external ip
get/myip: ; curl 'https://api.ipify.org'; echo 

## Output list of submodules & repositories
dump/submodules: 

	@printf "$(YELLOW)\n%-46s%s\n\n$(BLUE)" "Submodule Name" "Submodule Repository" 
	@for F in $(MODULES); do	printf "%-45s@%s\n" $$F https://github.com/mateothegreat/$$F | sed -e 's/modules\///g' -e 's/ /./g' -e 's/@/ /' -e 's/-/ /'; done
	@printf "\n"

### Try to curl http & https from $(HOST)
testing-curl: testing/curlhttp testing/curlhttps

### Try to curl http://$(HOST)
testing/curlhttp:	guard-HOST	; @echo -n "${BLUE}Testing HTTP Response Code for${GREEN} http://$(HOST):${RESET} "; if [ "$(shell curl -o -I -L -s -w "%{http_code}\n" https://$(HOST) -u user:pass)" = "200" ]; then echo "${YELLOW}OK${RESET}"; else echo "${YELLOW}ERROR, non 200 reponse code${RESET}"; fi 

### Try to curl https://$(HOST)
testing/curlhttps:	guard-HOST	; @echo -n "${BLUE}Testing HTTP Response Code for${GREEN} https://$(HOST):${RESET} "; if [ "$(shell curl -o -I -L -s -w "%{http_code}\n" https://$(HOST) -u user:pass)" = "200" ]; then echo "${YELLOW}OK${RESET}"; else echo "${YELLOW}ERROR, non 200 reponse code${RESET}"; fi 

### Retrieve external IP from api.ipify.org
testing/getip: 					; curl https://api.ipify.org && echo