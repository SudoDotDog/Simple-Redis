# Paths
build := typescript/tsconfig.build.json
dev := typescript/tsconfig.dev.json

# NPX functions
tsc := node_modules/.bin/tsc
ts_node := node_modules/.bin/ts-node
mocha := node_modules/.bin/mocha

# Image
redis_tag := redis-test

# Docker
image_name := redis-test
image_tag := redis-test
image_repo := sudoo/redis-test

.IGNORE: clean-linux kill stop

main: run

dev:
	@echo "[INFO] Building for development"
	@NODE_ENV=development $(tsc) --p $(dev)

run: dev
	@echo "[INFO] Starting"
	@NODE_ENV=development \
	node app/index.js

build:
	@echo "[INFO] Building for production"
	@NODE_ENV=production $(tsc) --p $(build)

tests:
	@echo "[INFO] Testing with Mocha"
	@NODE_ENV=test $(mocha)

cov:
	@echo "[INFO] Testing with Nyc and Mocha"
	@NODE_ENV=test \
	nyc $(mocha)

install:
	@echo "[INFO] Installing dev Dependencies"
	@yarn install --production=false

install-prod:
	@echo "[INFO] Installing Dependencies"
	@yarn install --production=true

clean-linux:
	@echo "[INFO] Cleaning dist files"
	@rm -rf coverage

docker: build
	@echo "[INFO] Create docker image"
	@docker build -t $(image_name) -f Dockerfile ./

kill:
	@echo "[INFO] Killing docker image"
	@docker kill $(redis_tag)

stop: kill
	@echo "[INFO] Stopping docker image"
	@docker rm $(redis_tag)

redis:
	@echo "[INFO] Running redis with Docker"
	@docker run -it -p 6379:6379 --name $(redis_tag) redis:latest
