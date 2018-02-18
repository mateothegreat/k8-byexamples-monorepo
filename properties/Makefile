include .make/Makefile.inc

PROPERTIES 	:= $(shell find . -maxdepth 1 -mindepth 1 -type d 2> /dev/null | tr '\r\n' ' ')

deploy:		loop-deploy tests
rollback:	loop-rollback tests
tests:		loop-testing-curl

loop-%:		; @for F in $(PROPERTIES); do $(MAKE) -C $$F $*; done
