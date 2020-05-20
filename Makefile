USER_NAME=hataldir

default: all

build_comment:
	export USER_NAME=${USER_NAME} ; \
        cd src/comment ; \
        bash docker_build.sh
build_post:
	export USER_NAME=${USER_NAME} ; \
        cd src/post-py ; \
        bash docker_build.sh
build_ui:
	export USER_NAME=${USER_NAME} ; \
        cd src/ui ; \
        bash docker_build.sh
build_prometheus:
	export USER_NAME=${USER_NAME} ; \
        cd monitoring/prometheus ; \
        bash build.sh

build: build_comment build_post build_ui build_prometheus


push_comment:
	docker push ${USER_NAME}/comment
push_post:
	docker push ${USER_NAME}/post
push_ui:
	docker push ${USER_NAME}/ui
push_prometheus:
	docker push ${USER_NAME}/prometheus

push: push_comment push_post push_ui push_prometheus

run:
	cd src ; \
        docker-compose up -d

all: build push run

