NAME 	:= tquach/cassandra

all: build

build:
	docker build --no-cache -rm -t ${NAME}:cluster ./cassandra-cluster
	docker build --no-cache -rm -t ${NAME}:base ./cassandra-base
	docker build --no-cache -rm -t ${NAME} ./cassandra

run: build
	docker run -rm -d --name cassandradb -p 9042:9042 tquach/cassandra

default: build

.PHONY: build clean run
