NAME	= mateothegreat/docker-alpine-drupal
ALIAS	= drupal
VERSION	= 1.0.0

.PHONY:	all build test tag_latest release

all:	clean build

build:

	@echo "Building an image with the current tag $(NAME):$(VERSION).."
	
	docker build 	--rm 	\
					--tag $(NAME):$(VERSION) \
					.

run:

	docker run 	--rm -it 				                        \
				--volume $(PWD)/jenkins_home:/var/jenkins_home 	\
				--publish 8080:8080		                        \
				--publish 50000:50000                           \
				--name $(ALIAS)                                 \
				$(NAME):$(VERSION)
	
shell:

	docker run 	--rm -it 				                        \
				--volume $(PWD)/jenkins_home:/var/jenkins_home 	\
				--publish 8080:8080		                        \
				--publish 50000:50000                           \
				--name $(ALIAS)                                 \
				--entrypoint /bin/sh                            \
				$(NAME):$(VERSION)

tag_latest:

	docker tag $(NAME):$(VERSION) $(NAME):latest

release:

	docker push $(NAME)