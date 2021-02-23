#!/bin/bash

# NOTE: this is only an example file on how to initialize the docker swarm with 1 master VM and 3 worker VM.
# IMPORTANT: make to open the all ports in the firewalls of the swarm nodes to enable swarm communication! (TCP 2376, 2377, 7946 and UDP 7946, 4789), e.g. for CENTOS
# firewall-cmd --add-port=2376/tcp --permanent
# firewall-cmd --add-port=2377/tcp --permanent
# firewall-cmd --add-port=7946/tcp --permanent
# firewall-cmd --add-port=7946/udp --permanent
# firewall-cmd --add-port=4789/udp --permanent

ssh root@10.0.0.1 "docker swarm init" #returns <swarmToken>
ssh root@10.0.0.2 "docker swarm join --token <swarmToken> 10.0.0.1:2377"
ssh root@10.0.0.3 "docker swarm join --token <swarmToken> 10.0.0.1:2377"
ssh root@10.0.0.4 "docker swarm join --token <swarmToken> 10.0.0.1:2377"

# NOTE: this is only an example file on how to assign lables for each of the swarm nodes.
# Services defined in the docker-compose.yaml may reference this label in order for Docker to know where the service should be deployed.
ssh root@10.0.0.1 "docker node update --label-add role=master 10.0.0.1"
ssh root@10.0.0.1 "docker node update --label-add role=analytics 10.0.0.2"
ssh root@10.0.0.1 "docker node update --label-add role=batch_processing 10.0.0.3"
ssh root@10.0.0.1 "docker node update --label-add role=stream_processing 10.0.0.4"

# NOTE: copy git repository to every swarm node bevor continuing, preferably under /home/
ssh root@10.0.0.1 "git clone https://github.com/SCCH-KVS/AVUBDI/ /home"
ssh root@10.0.0.2 "git clone https://github.com/SCCH-KVS/AVUBDI/ /home"
ssh root@10.0.0.3 "git clone https://github.com/SCCH-KVS/AVUBDI/ /home"
ssh root@10.0.0.4 "git clone https://github.com/SCCH-KVS/AVUBDI/ /home"

# Infrastructure Deployment to the Swarm
ssh root@10.0.0.1 "docker stack deploy --compose-file /home/AVUBDI/docker-compose.yml cogniplant"