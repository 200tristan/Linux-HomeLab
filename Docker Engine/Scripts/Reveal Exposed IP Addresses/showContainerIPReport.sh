#!/bin/bash

# Get list of all running docker containers
container_list=$(docker ps --format "{{.Names}}")

# Loop through each container and run "curl www.ifconfig.me"
for container_name in $container_list
do
    echo "Running curl command in container: $container_name"
    docker exec $container_name curl www.ifconfig.me
done > report.txt

echo "Job Complete: Report generated in report.txt"