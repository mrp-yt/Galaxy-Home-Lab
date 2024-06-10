#
# Checks and removes unused docker images
#

#!/bin/bash

# Function to check if a Docker image is in use
is_image_in_use() {
    local image_id=$1
    # Check if there are any running or stopped containers using the image
    docker ps -a --format '{{.Image}}' | grep -q "${image_id}"
}

# Function to delete a Docker image if not in use
delete_unused_image() {
    local image_id=$1
    if is_image_in_use "$image_id"; then
        echo "Image ${image_id} is in use."
    else
        echo "Image ${image_id} is not in use. Deleting..."
        docker rmi "${image_id}"
    fi
}

# List all Docker images
docker images --format '{{.ID}}' | while read -r image_id; do
    delete_unused_image "$image_id"
done

