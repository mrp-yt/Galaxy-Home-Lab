
[Garage S3](https://garagehq.deuxfleurs.fr/) - An open-source distributed object storage service tailored for self-hosting. 

This guide provides easy-to-follow instructions to quickly set it up using Docker and Docker Compose as a **Standalone Single-Node**. This is perfect for home labs, personal use, or when data redundancy across multiple servers is not needed.

## Prerequisites

- **Docker** and **Docker Compose** installed on your server or local machine.

---

## Step 1: Prepare the Directory Structure

Create a dedicated folder for your Garage deployment.
*I Recommend to create a user and create folders inside users HOME directory* 

```bash
mkdir -p ~/garage-s3/data
mkdir -p ~/garage-s3/meta
mkdir -p ~/garage-s3/config
cd ~/garage-s3
```

- `meta`: Store metadata (ideally on an SSD/NVMe for high performance).
- `data`: Where your actual bucket and object storage data will reside (can be a large HDD).
- `config`: Will store your `garage.toml` configuration file.

---

## Step 2: Create the `docker-compose.yml` File

In the `~/garage-s3` folder, create a file named `docker-compose.yml` and paste the following content:

```yaml
services:
  garage:
    image: dxflrs/garage:v2.2.0
    container_name: garage-s3
    restart: unless-stopped
    ports:
      - "3900:3900"   # Port for connecting to S3 Bucket
    volumes:
      - ./meta:/var/lib/garage/meta
      - ./data:/var/lib/garage/data
      - ./config/garage.toml:/etc/garage.toml:ro
    environment:
      - TZ=Europe/London
```

---

## Step 3: Create the Garage Configuration File

Garage requires a configuration file to declare its RPC secret, metadata, and storage locations. 

Create a file named `garage.toml` inside the `config` folder:

```bash
nano config/garage.toml
```

Open `config/garage.toml` in your favorite editor and paste the following baseline configuration:

```toml
metadata_dir = "/var/lib/garage/meta"
data_dir = "/var/lib/garage/data"

# Important: Set to 1 for single-node setups. (Default is 3, which will fail with 1 node)
replication_factor = 1

# Internal RPC for local Garage processes only
rpc_bind_addr = "[::]:3901"

[s3_api]
s3_region = "garage"
api_bind_addr = "[::]:3900"
root_domain = "[.s3.example.com]" # Update to your local domain, or leave as-is if using path-style requests

[s3_web]
bind_addr = "[::]:3902"
root_domain = "[.web.example.com]" # Optional, if using Garage for web hosting

[admin]
api_bind_addr = "[::]:3903"
```

Next, securely generate and **insert** the `rpc_secret` into your configuration file below the `rpc_bind_addr` line by running this command in your terminal:

```bash
sed -i '/rpc_bind_addr = "\[::\]:3901"/a rpc_secret = "'$(openssl rand -hex 32)'"' config/garage.toml
```

> **Note**: Because this is a single-node configuration, cluster-specific settings like `rpc_public_addr` have been removed for security and simplicity.

---

## Step 4: Start the Container

Now that everything is ready, spin up the container using Docker Compose:

```bash
sudo docker compose up -d
```
*(If you are on newer Docker versions, the command might be `docker compose up -d`)*

Verify the container is running:
```bash
sudo docker ps
```

---

## Step 5: Configure Garage using Admin CLI

Since Garage is fresh, you need to initiate the cluster and assign a layout.

**Check the Node ID:**
```bash
sudo docker exec -it garage-s3 /garage status
```
*Take a note of your Node ID!*

**Configure the Node Layout:**
Assign your node to the cluster with a capacity (e.g., 10G or whatever your disk size is) and a zone (e.g., dc1).
```bash
sudo docker exec -it garage-s3 /garage layout assign -z dc1 -c [CAPACITY] [YOUR_NODE_ID]
```
*(Replace `[YOUR_NODE_ID]` with the ID returned by the `status` command.)*

**Apply the Layout:**
```bash
sudo docker exec -it garage-s3 /garage layout apply --version 1
```

---

## Step 6: Create an S3 Key and Bucket

Your lightweight S3 server is running! Let's create an Access Key and Bucket to test it out.

**Generate an Access Key:**
```bash
sudo docker exec -it garage-s3 /garage key create [USER-KEY]
```
*Make note of the `Key ID` and `Secret Key` printed in the console.*

**Create a Bucket:**
```bash
sudo docker exec -it garage-s3 /garage bucket create [BUCKET-NAME]
```

**Grant Key Access to the Bucket:**
```bash
sudo docker exec -it garage-s3 /garage bucket allow [BUCKET-NAME] --read --write --owner --key [USER-KEY]
```

## You're Done! 🎉

You can now connect any S3 compatible tool (like **AWS CLI**, **Cyberduck**, or **Rclone**) to `http://localhost:3900` (or `http://[LOCAL_IP]:3900`) using the `Key ID` and `Secret Key` you just generated.
