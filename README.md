# AVUBDI
Github Repository for a Versatile Usable Big Data Infrastructure (AVUBDI) in Docker.

## Development Environment

* Dell XPS 7590
* Intel Core i7-9750H (6 Cores)
* 64 GB DDR4-2666 SODIMM Memory
* 2TB NVMe PCIe M.2 SSD

## Docker Host Environment

* VMWare Workstation 15 Player
* CentOS 8 + installed docker engine + compose
* 50 GB Memory
* 4 Cores

## Big Data Components

We split the used big data components into 3 parts for better understanding.

### Master Stack / Head Stack / Coordination Stack

This group consists of technologies responsible for data ingestion, distribution, validation, management and coordination.

| Component        | Description                                                                                                                                                                                                                                                                                          | Docker Image                          |
|------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------|
| [Kafka](https://kafka.apache.org/)            | Distributed and scaleable streaming platform that supports real-time & batch processing with high throughput.                                                                                                                                                                                        | confluentinc/cp-kafka:5.5.0           |
| [Kafka Connect](https://docs.confluent.io/current/connect/index.html)    | Kafka Connect is a framework for connecting Kafka with external systems such as databases, key-value stores, search indexes, and file systems.                                                                                                                                                       | confluentinc/cp-kafka-connect:5.5.0   |
| [Kafka Rest Proxy](https://docs.confluent.io/current/kafka-rest/index.html) | The Kafka REST Proxy provides a RESTful interface to a Kafka cluster. Examples of use cases include reporting data to Kafka from any frontend app built in any language, ingesting messages into a stream processing framework that doesn’t yet support Kafka, and scripting administrative actions. | confluentinc/cp-kafka-rest:5.5.0      |
| [Schema Registry](https://docs.confluent.io/current/schema-registry/index.html)  | Schema Registry provides a serving layer for the metadata. It provides a RESTful interface for storing and retrieving your Avro®, JSON Schema, and Protobuf schemas. It works like a charm in combination with Kafka and enables us to hold the whole infrastructure in a schema consistent state.   | confluentinc/cp-schema-registry:5.5.0 |
| [Zookeeper](https://zookeeper.apache.org/)        | ZooKeeper is a centralized service for maintaining configuration information, naming, providing distributed synchronization, and providing group services. All of these kinds of services are used in some form or another by distributed applications.                                              | confluentinc/cp-zookeeper:5.5.0       |

### Slave Stack / Worker Stack / Analytical Stack

This group consists of technologies responsible for complex data analytics and visualization on stream and batch data.

| Component        | Description                                                                                                                                                                               | Docker Image          |
|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------|
| [Spark-Master](https://spark.apache.org/)     | Apache Spark is a unified analytics engine for big data processing, with built-in modules for streaming, SQL, machine learning and graph processing. In this we can deploy any spark job. | bde2020/spark-master  |
| [Spark-Worker(x2)](https://spark.apache.org/) | Apache Spark is a unified analytics engine for big data processing, with built-in modules for streaming, SQL, machine learning and graph processing.                                      | bde2020/spark-worker  |                                                                         | apache/zeppelin:0.9.0 |
| [InfluxDB](https://www.influxdata.com/)         | InfluxDB is the leading open source time series database for monitoring metrics and events and providing real-time visibility into stacks, sensors, and systems.                          | influxdb:1.8.0        |
| [Chronograf](https://www.influxdata.com/time-series-platform/chronograf/)       | Chronograf is a visualization tool for time series data in InfluxDB.                                                                                                                      | chronograf:1.8.4      |

### Monitoring Stack / Management Stack

| Component                      | Description                                                                                                                                               | Docker Image               |
|--------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------|
| [Kafka Connect UI](https://hub.docker.com/r/landoop/kafka-connect-ui)               | Kafka Connect UI is a web tool for Kafka Connect for setting up and managing connectors for multiple connect clusters.                                    | landoop/kafka-connect-ui   |
| [Kafka Cluster UI](https://github.com/obsidiandynamics/kafdrop)               | Kafdrop is a UI for monitoring Apache Kafka clusters. The tool displays information such as brokers, topics, partitions, and even lets you view messages. | obsidiandynamics/kafdrop   |
| [Schema Registry UI](https://hub.docker.com/r/landoop/schema-registry-ui)             | The Schema Registry UI is a fully-featured tool for your underlying schema registry that allows visualization and exploration of registered schemas.      | landoop/schema-registry-ui |
| [Docker Container Management UI](https://www.portainer.io/) | Portainer is a lightweight management UI which allows easy management of the Docker host or Swarm cluster.                                                | portainer/portainer        |
| [Grafana](https://grafana.com/)                        | Grafana is the open source analytics & monitoring solution for a lot of database (in our case InfluxDB).                                                  | grafana/grafana:7.0.6      |

## Docker

## What is Docker Engine

Docker Engine is an open source containerization technology for building and containerizing your applications. Docker Engine acts as a client-server application with: A server with a long-running daemon process dockerd . APIs which specify interfaces that programs can use to talk to and instruct the Docker daemon.

[Docker Engine](https://docs.docker.com/engine/)

## What is Docker Compose

Docker Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a YAML file to configure your application's services.

[Docker Compose](https://docs.docker.com/compose/)

### Installation of Docker Engine

#### CentOS

Install the yum-utils package (which provides the yum-config-manager utility) and set up the stable repository.

```shell
sudo yum install -y yum-utils
```

```shell
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

Install the latest version of Docker Engine and containerd.

```shell
sudo yum install docker-ce docker-ce-cli containerd.io
```

Start Docker

```shell
sudo systemctl start docker
```

Install Docker Compose

```shell
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

Make Docker Compose Binary an Executable

```shell
sudo chmod +x /usr/local/bin/docker-compose
```

Verify that Docker Engine and Docker Compose is installed correctly by running the cogniplant docker-compose.yml file.

```shell
sudo docker-compose up -d --build
```

The output should look like the following:

```txt
[mmayr@localhost Cogniplant]$ docker-compose up -d
Creating spark-master            ... done
Creating zookeeper-1             ... done
Creating influxdb                ... done
Creating portainer               ... done
Creating cogniplant_chronograf_1 ... done
Creating cogniplant_grafana_1    ... done
Creating kafka-1                 ... done
Creating spark-worker-2          ... done
Creating spark-worker-1          ... done
Creating kafka-schema-registry   ... done
Creating kafdrop                 ... done
Creating schema-registry-ui      ... done
Creating kafka-rest-proxy        ... done
Creating kafka-connect           ... done
Creating kafka-connect-ui        ... done
```

## Dashboard UIs

### Preliminary

Use the virtualization host ip address for connecting to the different UIs. This IP and additionally the ports can be configured in the .env file!

### Portainer

[Dashboard Portainer](http://127.0.0.1:9000/)

### Kafka Monitoring UI (Kafdrop)

[Kafka Monitoring UI](http://127.0.0.1:9001/)


### Spark Stream & Batch Master UI

[Spark Stream Master UI](http://127.0.0.1:9002/)

[Spark Batch Master UI](http://127.0.0.1:9003/)

### Kafka Connect UI

[Kafka Connect UI](http://127.0.0.1:9004/)

### Schema Registry UI

[Schema Registry UI](http://127.0.0.1:9005/)

### Grafana

[Grafana](http://127.0.0.1:9006/)

### Chronograf

[Chronograf](http://127.0.0.1:9007/)
