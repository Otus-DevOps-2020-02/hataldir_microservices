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
build_alertmanager:
	export USER_NAME=${USER_NAME} ; \
        cd monitoring/alertmanager ; \
        bash build.sh
build_telegraf:
	export USER_NAME=${USER_NAME} ; \
        cd monitoring/telegraf ; \
        bash build.sh
build_grafana:
	export USER_NAME=${USER_NAME} ; \
        cd monitoring/grafana ; \
        bash build.sh
build_stackdriver:
	export USER_NAME=${USER_NAME} ; \
        cd monitoring/stackdriver ; \
        bash build.sh
build_fluentd:
	export USER_NAME=${USER_NAME} ; \
        cd logging/fluentd ; \
        bash build.sh

build: build_comment build_post build_ui build_prometheus build_alertmanager build_telegraf build_grafana build_stackdriver build_fluentd

build_src: build_post build_ui build_comment


push_comment:
	docker push ${USER_NAME}/comment
push_post:
	docker push ${USER_NAME}/post
push_ui:
	docker push ${USER_NAME}/ui
push_prometheus:
	docker push ${USER_NAME}/prometheus
push_alertmanager:
	docker push ${USER_NAME}/alertmanager
push_telegraf:
	docker push ${USER_NAME}/telegraf
push_grafana:
	docker push ${USER_NAME}/grafana
push_stackdriver:
	docker push ${USER_NAME}/stackdriver
push_fluentd:
	docker push ${USER_NAME}/fluentd

push: push_comment push_post push_ui push_prometheus push_alertmanager push_telegraf push_grafana push_stackdriver push_fluentd

run:
	cd docker ; \
        docker-compose up -d

monitor:
	cd docker ; \
        docker-compose -f docker-compose-monitoring.yml up -d

log:
	cd docker ; \
        docker-compose -f docker-compose-logging.yml up -d


all: build push run monitor log

