TIME		:= $(shell date +"%Y-%m-%d_%H%M%S")
SELF_DIR    := $(dir $(lastword $(MAKEFILE_LIST)))
export

include $(SELF_DIR)/includes/colors.mk
include $(SELF_DIR)/includes/help.mk

include $(SELF_DIR)/includes/git.mk

include $(SELF_DIR)/includes/docker.mk
include $(SELF_DIR)/includes/kubectl.mk
include $(SELF_DIR)/includes/tls.mk
