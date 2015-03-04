# MySQL Galera on Mesos

Compare ["MariaDB Galera on a Mesos Cluster with Docker"](http://sttts.github.io/galera/mesos/2015/03/04/galera-on-mesos.html).

```bash
$ docker run -d -v /data:/var/lib/mysql -p 3306 -p 8080 \
    -e XTRABACKUP_PASSWORD=abc -e MYSQL_PASSWORD=secret \
    sttts/galera-mariadb-10.0-xtrabackup seed

$ docker run -d -v /data:/var/lib/mysql -p 3306 -p 8080 \
    sttts/galera-mariadb-10.0-xtrabackup \
    -e XTRABACKUP_PASSWORD=abc \
    node 172.17.0.81,172.17.0.97

$ docker run -d -v /data:/var/lib/mysql -p 3306 -p 8080 \
    sttts/galera-mariadb-10.0-xtrabackup \
    -e XTRABACKUP_PASSWORD=abc \
    node 172.17.0.81 --any-mysql-argument-you-like
```
