docker/build: guard-TAG guard-AUTHOR

	@echo "Building an image with the current tag $(TAG).."

	docker build    --build-arg AUTHOR=$(AUTHOR) \
					--tag $(TAG) \
					.
