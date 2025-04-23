# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»-***Вуколов Евгений***  
 
### Подготовка к выполнению задания
 
1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.
 
---
## Задание 1. Yandex Cloud 
 
**Что нужно сделать**
 
1. Создать бакет Object Storage и разместить в нём файл с картинкой:
 
 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:
 
 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:
 
 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.
 
Полезные документы:
 
- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).
 
---
## Задание 2*. AWS (задание со звёздочкой)
 
Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.
 
**Что нужно сделать**
 
Используя конфигурации, выполненные в домашнем задании из предыдущего занятия, добавить к Production like сети Autoscaling group из трёх EC2-инстансов с  автоматической установкой веб-сервера в private домен.
 
1. Создать бакет S3 и разместить в нём файл с картинкой:
 
 - Создать бакет в S3 с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать доступным из интернета.
2. Сделать Launch configurations с использованием bootstrap-скрипта с созданием веб-страницы, на которой будет ссылка на картинку в S3. 
3. Загрузить три ЕС2-инстанса и настроить LB с помощью Autoscaling Group.
 
Resource Terraform:
 
- [S3 bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket)
- [Launch Template](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template).
- [Autoscaling group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group).
- [Launch configuration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration).
 
Пример bootstrap-скрипта:
 
```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>


# **Решение**

1. Для начала,в Yandex cloud, создал сервисный аккаунт и назначил роли: 

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-22%20163218.png)

2. Создал бакет в Object Storage с произвольным именем my-bucket-evgen и остальные ресурсы в Yandex cloud при помощи terraform : 

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20125314.png)

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20133113.png)
- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20140617.png)

3. Проверяю по IP адресу балансировщика доступ к файлу (картинка положенная в бакет) : 

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20133202.png)

4. По заданию нужно отключить одну или две из 3-х VM и проверить работоспособность. Отключаю сначала одну, а потом вторую VM и проверяю:

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20133853.png)

- Как видно из скриншота, VM останавливаются, а затем вновь пересоздаются.
Балансировщик нагрузки постоянно мониторит состояния VM и переключается на рабочие, таким образом поддерживая доступность сайта.

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20134413.png)

5. Проверка работоспособности целевой группы : 

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20134930.png)
 
6. Вывод логов после остановки и пересоздания VM : 

- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20135656.png)

7. Проверка работоспособности сетевого балансировщика нагрузки после отключения и пересоздания VM, показывает что работает нормально  :
 
- ![scrin](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/Снимок%20экрана%202025-04-23%20140454.png)


- Ссылки на манифесты: 

[main.tf](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/config.tf/main.tf)

[outputs.tf](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/config.tf/outputs.tf)

[ssh_keys.tf](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/config.tf/ssh_keys.tf)

[terraform.tfvars](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/config.tf/terraform.tfvars)

[variables.tf](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/config.tf/variables.tf)

[image.jpg](https://github.com/Evgenii-379/15.2.md-Computing-Power-Load-Balancers/blob/main/config.tf/data/image.jpg)

































