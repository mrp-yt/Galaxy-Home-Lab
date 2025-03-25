#docker #compose 

```yaml
version: "3"
services:
  server:
    image: ghcr.io/gotify/server
    restart: unless-stopped
    container_name: Gotify
    ports:
      - 8180:80
    volumes:
      - /home/mrp/docker/gotify:/app/data

    # optional --------------------------
    networks:
      - galaxy
networks:
  galaxy:  
    driver: bridge
    # optional --------------------------
```
