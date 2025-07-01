#!/bin/bash
docker compose down
docker compose up -d
docker compose exec dotfiles /bin/zsh
