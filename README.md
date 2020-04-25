# hataldir_microservices
hataldir microservices repository


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