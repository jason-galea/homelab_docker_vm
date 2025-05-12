#!/usr/bin/bash


### Install docker
### https://docs.docker.com/engine/install/debian/
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

docker version
docker compose version
# sudo docker run hello-world


### Clone repos
REPOS=(
    # https://github.com/jason-galea/homelab_nginx.git
    # https://github.com/jason-galea/homelab_pihole.git
    https://github.com/jason-galea/price_scraper.git
    # bookstack
    # unifi
    # wekan
)
for REPO in "${REPOS[@]}"; do
    echo "cloning $REPO"
    git clone $REPO
    (
        cd $REPO
        pwd
        echo "docker compose up -d"
    )
    sleep 1
done
