# hataldir_microservices
hataldir microservices repository
[![Build Status](https://travis-ci.com/Otus-DevOps-2020-02/hataldir_microservices.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-02/hataldir_microservices)

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


