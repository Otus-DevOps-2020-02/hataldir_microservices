# hataldir_microservices
hataldir microservices repository
[![Build Status](https://travis-ci.com/Otus-DevOps-2020-02/hataldir_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-02/hataldir_microservices)


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


