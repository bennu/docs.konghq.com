.PHONY: clean install run test deploy docker-run docker-test docker-bash

DOCKER_COMMAND=docker run -it -p 3000:3000 -p 3001:3001 --rm -v $$PWD:/srv/jekyll kongdocs
NODE_MODULES=node_modules

clean:
	rm -rf dist
	rm -rf node_modules

install:
	npm install -f
	bundle install
	gulp clean

node_modules: install

run: $(NODE_MODULES)
	gulp dev

test: $(NODE_MODULES)
	npm run test

deploy: test
	npm run deploy

docker-build:
	docker build -t kongdocs .

docker-run: docker-build
	$(DOCKER_COMMAND)

docker-test: docker-build
	DOCKER_COMMAND make test

docker-deploy: docker-build
	DOCKER_COMMAND make deploy

docker-bash: docker-build
	DOCKER_COMMAND bash
