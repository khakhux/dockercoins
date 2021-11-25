#!/bin/sh
tag=latest
git clone --branch 2021-11-axia --single-branch https://github.com/academiaonline-org/dockercoins
for app in hasher redis rng webui worker
do
docker build -t ${app}:${tag} ${app}
done
for app in hasher redis rng
do 
docker network create ${app}
done
cmd=redis-server
entrypoint=/usr/local/bin/docker-entrypoint.sh
image=redis
name=redis
network=redis
restart=always
user=nobody
volume=redis
volume_path=/data/
volume_ops=rw
workdir=/data/
docker run -d --entrypoint ${entrypoint} --name ${name} --network ${network} --read-only --restart ${restart} -u ${user} -v ${volume}:${volume_path}:${volume_ops} -w ${workdir} ${image}:${tag} ${cmd}
