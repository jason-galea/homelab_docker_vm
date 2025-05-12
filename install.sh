#!/usr/bin/bash


### Install docker
### https://docs.docker.com/engine/install/debian/
echo "==> Installing docker"
set +x
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
set -x

docker version
docker compose version
# sudo docker run hello-world


### Clone repos
echo "==> Cloning repos & starting services"
REPOS=(
    # homelab_nginx
    # homelab_pihole
    price_scraper
    # bookstack
    # unifi
    # wekan
)
for REPO in "${REPOS[@]}"; do
    echo "==> Cloning $REPO"
    if [[ ! -f $REPO ]]; then
        git clone https://github.com/jason-galea/$REPO.git
    fi
    (
        cd $REPO
        pwd
        echo "==> Starting $REPO"
    )
    sleep 1
done
