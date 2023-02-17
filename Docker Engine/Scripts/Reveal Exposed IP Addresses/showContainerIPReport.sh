#!/bin/bash

# Get list of all running docker containers
container_list=$(docker ps --format "{{.Names}}")

# Set column headers for report
printf "%-20s %-20s %-20s\n" "Container Name" "Public IP" "Private IP" > report.txt

# Loop through each container and run "curl www.ifconfig.me"
for container_name in $container_list
do
    public_ip=$(docker exec $container_name curl -s www.ifconfig.me)
    private_ip=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' $container_name)
    printf "%-20s %-20s %-20s\n" "$container_name" "$public_ip" "$private_ip" >> report.txt
done

echo "Job Complete: Report generated in report.txt"