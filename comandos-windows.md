# redis

docker run -d --name redis --network webui --read-only --restart always -u nobody -v ${PWD}/redis/data/:/data/:rw redis:latest

# hasher

para sacar el entrypoint hay que localizar la ruta de ruby en la imagen
docker run --rm hasher:latest which ruby

para comprobar si necesita volumen (en este caso no 
docker run --name ruby --rm -d -t ruby:alpine

para comprobar si necesita usuario
docker inspect ruby:latest | grep user

para comprobar si necesita working directory
docker inspect ruby:latest | grep working

para comprobar las variables de entorno hay que inspeccionar el Dockerfile de ruby

docker run -d --name hasher -e GEM_HOME=/usr/local/bundle -e BUNDLE_SILENCE_ROOT_WARNING=1 -e BUNDLE_APP_CONFIG="$GEM_HOME" -e PATH=$GEM_HOME/bin:$PATH --entrypoint /usr/local/bin/ruby --network hasher --read-only --restart always -u nobody -v ${PWD}/hasher/hasher.rb:/hasher/hasher.rb:ro -w /hasher hasher:latest hasher.rb

# rng

para sacar el entrypoint hay que localizar la ruta de ruby en la imagen
docker run --rm rng:latest which python

para sacar volumenes
docker run --rm --name test -d -t python:alpine
docker diff test
ojo: deberia ser necesario incluir los volumenes para /usr/local/lib/python3.10/__pycache__/_... pero se estan creando los ficheros a pesar de estar ejecutado en read-only,
habria que investigarlo, los volumenes que habria que mapear se puede sacar de https://github.com/academiaonline-org/dockercoins/blob/2021-11-axia/docker-deploy.sh

docker run -d --name rng --entrypoint=/usr/local/bin/python --network rng --read-only --restart always -u nobody -v ${PWD}/rng/rng.py:/rng/rng.py:ro -w /rng rng:latest rng.py

# worker

docker run -d --name worker --entrypoint=/usr/local/bin/python --network worker --read-only --restart always -u nobody -v ${PWD}/worker/worker.py:/worker/worker.py:ro -w /worker worker:latest worker.py

docker network connect redis worker
docker network connect rng worker
docker network connect hasher worker

# webui

docker run -d --name webui --entrypoint=node --network webui --read-only --restart always -u root -p 8080:8080 -v ${PWD}/webui/webui.js:/webui.js:ro  -v ${PWD}/webui/files/:/files/:ro webui:latest webui.js
