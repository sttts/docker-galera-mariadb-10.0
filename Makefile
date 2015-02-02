all: build

.PHONY: build push master node

build:
	docker build -t "sttts/galera-mariadb-10.0-xtrabackup:$(git rev-parse HEAD)" .

push:
	docker push "sttts/galera-mariadb-10.0-xtrabackup:$(git rev-parse HEAD)"

master:
	docker run -it -e XTRABACKUP_PASSWORD=geheim -e MYSQL_ROOT_PASSWORD=geheim -p 8080:8080 -p 3306:3306 --name master --rm sttts/galera-mariadb-10.0-xtrabackup:$(git rev-parse HEAD) master

node:
	docker run -it -e XTRABACKUP_PASSWORD=geheim -e MYSQL_ROOT_PASSWORD=geheim -p 8081:8080 --name node --rm sttts/galera-mariadb-10.0-xtrabackup:$(git rev-parse HEAD) node 1.2.3.4