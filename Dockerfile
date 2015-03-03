FROM ubuntu:14.04
MAINTAINER Dr. Stefan Schimanski <stefan.schimanski@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN echo "deb http://archive.ubuntu.com/ubuntu trusty main universe" > /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y install software-properties-common curl supervisor python-pip host
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
RUN add-apt-repository 'deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/10.0/ubuntu trusty main'
RUN apt-get -y update
RUN apt-get -y install mariadb-galera-server galera mariadb-client xtrabackup socat unzip
RUN pip install supervisor-stdout

RUN curl -f -L -o/bin/galera-healthcheck 'https://github.com/sttts/galera-healthcheck/releases/download/v20150303/galera-healthcheck_linux_amd64'
RUN test "$(sha256sum /bin/galera-healthcheck | awk '{print $1;}')" = "86f60d9d82b1f9d2d474368ed7e81a0a361508031a292244847136b0ed2ee770"
RUN chmod +x /bin/galera-healthcheck

RUN sed -i 's/#? *bind-address/# bind-address/' /etc/mysql/my.cnf
RUN sed -i 's/#? *log-error/# log-error/' /etc/mysql/my.cnf
ADD conf.d/utf8.cnf /etc/mysql/conf.d/utf8.cnf
ADD conf.d/timezone.cnf /etc/mysql/conf.d/timezone.cnf
ADD conf.d/slow_query_log.cnf /etc/mysql/conf.d/slow_query_log.cnf

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 3306 4444 4567 4568
ADD start /bin/start
RUN chmod +x /bin/start
ENTRYPOINT ["/bin/start"]