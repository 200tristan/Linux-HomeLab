#!/bin/bash

# Get all docker container IDs
container_ids=$(docker ps -aq)

# Print header row
printf "| %-12s | %-30s | %-20s | %-15s | %-10s |\n" "CONTAINER ID" "CONTAINER NAME" "RAM USAGE (PERCENT)" "PUBLIC IP" "STATUS"
printf "|%-14s|%-32s|%-22s|%-17s|%-12s|\n" "" "$(printf '%0.s-' {1..30})" "$(printf '%0.s-' {1..20})" "$(printf '%0.s-' {1..15})" "$(printf '%0.s-' {1..10})"

# Loop through each container
for id in $container_ids
do
  # Get container name
  container_name=$(docker inspect --format '{{.Name}}' $id | sed 's/\///')

  # Get RAM usage (percent)
  ram_usage=$(docker stats --no-stream $id | awk '{print $4}' | tail -n 1)

  # Get public IP
  public_ip=$(docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $id)

  # Get container status
  container_status=$(docker inspect --format '{{.State.Status}}' $id)

  # Print row for container
  printf "| %-12s | %-30s | %-20s | %-15s | %-10s |\n" "$id" "$container_name" "$ram_usage" "$public_ip" "$container_status"
done

# Print footer row
printf "|%-14s|%-32s|%-22s|%-17s|%-12s|\n" "" "$(printf '%0.s-' {1..30})" "$(printf '%0.s-' {1..20})" "$(printf '%0.s-' {1..15})" "$(printf '%0.s-' {1..10})"
