
# Reveal Exposed IP Addresses

This script first gets a list of all running docker containers using the docker ps command and stores it in the container_list variable. It then loops through each container in the list and runs the curl www.ifconfig.me command inside the container using the docker exec command. The output of each command is appended to report.txt