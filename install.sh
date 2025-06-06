#!/usr/bin/bash


### Install docker
### https://docs.docker.com/engine/install/debian/
echo -e "\n==> Installing docker"
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

# docker version
# docker compose version
# sudo docker run hello-world


### Clone repos
echo -e "\n==> Cloning repos & starting services"
REPOS=(
    homelab_nginx
    homelab_pihole
    price_scraper
    homelab_bookstack
    # homelab_unifi
    # homelab_wekan
)
for REPO in "${REPOS[@]}"; do
    REPO_PATH="$HOME/$REPO"

    if [ ! -d $REPO_PATH ]; then
        echo -e "\n==> Cloning $REPO"
        git clone https://github.com/jason-galea/$REPO.git $REPO_PATH
    else
        echo -e "\n==> Repo '$REPO' already exists at '$REPO_PATH', pulling latest changes"
        git -C $REPO_PATH pull
    fi

    ### compose -f?? ehhh whatever
    (
        echo -e "\n==> Changing dir to '$REPO_PATH'"
        cd $REPO_PATH
        echo -e "\n==> Starting '$REPO'"
        docker compose up -d
    )
    sleep 1
done
