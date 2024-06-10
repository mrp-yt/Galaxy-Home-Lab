#
# checks for unused docker networks and removes them
#
#!/bin/bash

# Function to check if a Docker network is in use
is_network_in_use() {
    local network_id=$1
    # Check if there are any containers connected to the network
    docker network inspect "$network_id" --format '{{json .Containers}}' | grep -q '"Name":"'
}

# Function to delete a Docker network if not in use
delete_unused_network() {
    local network_id=$1
    if is_network_in_use "$network_id"; then
        echo "Network ${network_id} is in use."
    else
        echo "Network ${network_id} is not in use. Deleting..."
        docker network rm "${network_id}"
    fi
}

# List all Docker networks excluding default ones (bridge, host, none)
docker network ls --format '{{.ID}} {{.Name}}' | while read -r network_id network_name; do
    if [[ "$network_name" != "bridge" && "$network_name" != "host" && "$network_name" != "none" ]]; then
        delete_unused_network "$network_id"
    fi
done