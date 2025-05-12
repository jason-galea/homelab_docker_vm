#!/usr/bin/bash

# ### TODO
# echo -e "\n==> Refreshing services"
# REPOS=(
#     # homelab_nginx
#     # homelab_pihole
#     price_scraper
#     # bookstack
#     # unifi
#     # wekan
# )
# for REPO in "${REPOS[@]}"; do

#     echo -e "\n==> Cloning $REPO"
#     if [ ! -d $REPO ]; then
#         git clone https://github.com/jason-galea/$REPO.git
#     fi

#     (
#         cd $REPO
#         pwd
#         echo -e "\n==> Starting $REPO"
#         docker compose up -d
#     )
#     sleep 1
# done
