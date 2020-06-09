# hataldir_microservices
hataldir microservices repository
[![Build Status](https://travis-ci.com/Otus-DevOps-2020-02/hataldir_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-02/hataldir_microservices)


Домашнее задание 19

Созданы манифесты типа Deployment для post, comment, ui и mongo.

Kubernetes The Hard Way:

Установлены утилиты cfssl и cfssljson.
Установлен kubectl

В GCP создана сеть kubernetes-the-hard-way, в ней подсеть 10.240.0.0/24
Созданы правила фаерволла, разрешающие tcp,udp,icmp внутри сети, а также icmp и порты tcp 22 и 6443 снаружи.
Создан статический IP адрес (34.78.220.238)

Созданы три виртуалки для контроллеров controller-0,1,2 и три worker-ноды worker-0,1,2

Сгенерирован ключ /root/.ssh/google_compute_engine
Сгенерированы сертификаты ca.pem и ca-key.pem, admin.pem и admin-key.pem, worker-*.pem и worker-*-key.pem, kube-controller-manager.pem и kube-controller-manager-key.pem,
kube-proxy.pem и kube-proxy-key.pem, kube-scheduler.pem и kube-scheduler-key.pem, kubernetes.pem и kubernetes-key.pem, service-account.pem и service-account-key.pem
Скопированы сертификаты worker* на worker-ноды и сертификаты ca, kubernetes, service-account на контроллеры.
В переменной окружения сохранен внешний адрес
Создны конфиги для worker-нод, kube-proxy, kube-controller-manager, kube-scheduler, пользователя admin.
Скопированы конфиги kubelet и kube-proxy на worker-ноды; admin, kube-controller-manager, kube-scheduler на контроллеры
Создан ключ шифрования, конфиг с ним, скопирован на контроллеры

На каждом контроллере:
Скачаны и установлены etcd, etcdctl
Скопированы сертификаты в /etc/etcd
Сохранены в переменные ip и hostname
Создан и запущен etcd.service 

Скачаны и установлены kube-apiserver, kube-controller-manager, kube-scheduler, kubectl
Созданы kube-apiserver.service, kube-controller-manager.service, kube-scheduler.service
Конфиги перемещены в  /var/lib/kubernetes/, создан конфиг /etc/kubernetes/config/kube-scheduler.yaml

Установлен nginx для обеспечения healthcheck

На одном контроллере:
Настроен RBAC

С локальной машины:
Создан балансировищк

На каждой ноде:
Установлены пакеты  conntrack ipset libipset3 socat
Проверено отсутствие свопа
Скачан и установлен kubernetes
Выполнена настройка сети для работы подов
Созданы конфиг и service для containerd
Созданы конфиг и service для kubelet
Созданы конфиг и service для kube-proxy

С локальной машины:
Настроен kubectl на доступ к кластеру

Настроена маршрутизация к сетям нод в GCP

Установлен аддон coredns, для теста его работы запущен контейнер busybox, в нем выполнен nslookup  

Протестировано шифрование
Протестирован deployment
Протетсирован port forwarding
Протестировано логирование
Протестирован exec в контейнере
Протестирован доступ к сервису снаружи

Запущены поды mongo, post, comment и ui

Все выполненные  команды сохранены в файле commands











Домашнее задание 18

Запущены три сервиса для обработки логов - fluentd, elasticsearch, kibana. Для fluentd установлены плагины fluentd и grok и написан конфиг.
Для работы elasticsearch на хостовой машине нужно было выполнить команду sysctl -w vm.max_map_count=262144.
Логирование сервисов post и ui переведено на драйвер fluentd. Kibana настроена на отображение логов, собираемых fluentd.

В конфиг fluentd добавлен фильтр по key_name log для парсинга сообщений с тегом log от сервиса post.
Для парсинга логов сервиса ui добавлены фильтры формата grok.

Запущен еще один сервис - zipkin. В docker-compose.yml для сервисов определена переменная ZIPKIN_ENABLED для включения трассировки.

Дополнительное задание 1

В fluentd добавлен еще один фильтр grok для разбора логов ui.

Дополнительное задание 2

Скачан "сломанный" код приложения. В Dockerfile всех сервисов добавлены переменные окружения, в docker_build.sh - тег logging. После этого сервисы запустились. 
С помощью zipkin обнаружено что при отображении поста функция db_find_single_post выполняется 3.01 секунды. В коде функции найдена создающая проблему строка  time.sleep(3).



Домашнее задание 17

Из конфига docker-compose выделен отдбелный конфиг для сервисов мониторинга.
Установлен cAdvisor, добавлен в Prometheus.
Установлена Grafana, импортирован дашборд Docker and system monitoring.
Создан новый дашборд UI_Service_monitoring, включающий графики по метрикам ui_request_count, ui_request_count с фильтром по http responses 4*, 5* и 95 процентиль по
ui_request_response_time_bucket.
Создан дашборд Business_Logic_Monitoring, включающий графики по post_count и comment_count.
Установлен Alertmanager, добавлен в Prometheus, настроена интеграция со Slack. Создан алерт, срабатывающий при недоступности любого из endpoints.

Дополнительное задание 1:

Запуск docker-compose для сервисов мониторинга, а также билд и пуш alertmanager добавлены в Makefile.
В докере настроено отображение метрик в формате Prometheus (metrics-addr) на порту 9323. Endpoint добавлен в Prometheus, в Grafana добавлен дашборд Docker Engine Metrics.
По сравнению с cAdvisor метрик собирается в 6 раз меньше.
Установлен telegraf, в нем включены inputs plugin docker и outputs plugin prometheus. Endpoint добавлен в Promethues, в Grafana добавлен дашборд Telegraf Metrics.
Создан еще один алерт. Добавлена отправка уведомлений на емейл.

Дополнительное задание 2:

Создан образ Grafana, в Dockerfile внесены настройка datasources и копирование дашбордов. Версия для этого нужна 5.1.
Установлен stackdriver_exporter, настроен на проект Docker в GCP,  добавлен в Prometheus. Собирает всего примерно 30 метрик с машины docker-host - данные по CPU, disk, network, boot integrity.

Дополнительное задание 3:

Установлен Trickster, Grafana настроена на использование его в качестве datasourse.



Домашнее задание 16


С помощью docker-host создана виртуалка в GCP, на нее поставлен prometheus и удален. 
Пересобраны образы микросервисов comment, ui, post с помощью docker_build.sh. Удалены параметры build для соответствующих сервисов из docker-compose.yml.
Для prometheus написан конфиг prometheus.yml и мини-докерфайл.
Prometheus добавлен как новый сервис в docker-compose с доступом к обоим сетям.
Промониторены некоторыые метрики, для теста отключен сервис post.
В prometheus.yml и docker-compose.yml добавлен еще один сервис для мониторинга за машиной docker-host - node_exporter.

Дополнительное задание 1.

Добавлен еще один сервис для мониторинга mongodb - percona/mongodb_exporter.

Дополнительное задание 2.

Добавлен еще один сервис для мониторинга за доступностью микросервисов - blackbox.

Дополнительное задание 3.

Написан Makefile, с помощью которого можно ребилдить все сервисы, пушить их в репозиторий и запускать проект.

https://hub.docker.com/u/hataldir



Домашнее задание 15


Создана виртуалка в GCP, на нее установлены gitlab и gitlab-runner в виде контейнеров докера.
Создан проект, в котором создан пайплайн, состоящий из стадий build, test, deploy.
В пайплайн добавлена установка приложения reddit, для него создан тест simpletest.rb.
Создано окружение dev
Добавлены стадии и окружения staging, production, jobs для них запускаются в ручном режиме и только при наличии тега в коммите.
Настроены динамические окружения для всех веток проекта кроме master.


Дополнительное задание 1

В шаг build добавлено создание контейнера с reddit.

Дополнительное задание 2

Для установки Runner использована роль Ansible riemers.gitlab-runner.

Добавлена интеграция со Slack.
Канал #denis_lunev, https://devops-team-otus.slack.com/archives/CUWMMTQ8H



Домашнее задание 14

Префикс имен контейнеров docker-compose меняется с помощью переменной COMPOSE_PROJECT_NAME.

Проверена работа сетевых драйверов none, host, bridge. 
Созданы сети front_net, back_net. Контейнеры post и comment добавлены к обоим сетям с помощью docker network connect.

Написан файл docker-compose.yml для запуска всего проекта с помощью docker-compose.
В него добавлено использование двух сетей и использование файла .env для переменных. Изменен префикс имен контейнеров.

Дополнительное задание:

Создан файл docker-compose.override.yml, изменяющий сервисы:
- каталоги comment, post-py и ui пробрасываются в контейнер как volumes (скопированы на docker-host) 
- comment и ui запускаются как puma --debug -w 2



Домашнее задание 13

Скачана версия reddit, состоящая из микросервисов comment, ui, post-py. Для каждого из них написаны докерфайлы и собраны образы.
Создана подсеть для работы приложения, запущены контейнеры comment,ui, post-py и mongo
У образа ui изменен базовый образ на ubuntu.
Создан подключаемый том reddit_db, подключен к контейнеру mongo.


Дополнительне задание 1:

Все переменные вынесены в отдельный файл, используемый в каждом контейнере с docker run --env-list.

Дополнительное задание 2:

У образов ui и comment изменен базовый образ на alpine.
Все RUN объединены в один.
Добавлено удаление пакета base-build после сборки приложения.




Домашнее задание 12

Команда параметр --pid host запускает контейнер в неймспейсе хостовой машины и он видит все ее процессы.

Установлены docker, docker-compose, docker-machine, gcloud-sdk. В GCP создан 
проект Docker.
С помощью docker-machine создана виртуалка docker-host.
Написан Dockerfile для устновки mongodb, ruby и приложения reddir в контейнере.
Создан образ и залит на DockerHub.

Дополнительное задание:

Написан шаблон terrraform, создающий заданное в переменной количество одинаковых виртуалок.
Написан шаблон packer, создающий образ с установленным докером.
Написаны плейбуки ansible -  устанавливающий докер и запускающий наш контейнер.


