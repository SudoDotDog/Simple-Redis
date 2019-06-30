# Paths
build := typescript/tsconfig.build.json
dev := typescript/tsconfig.dev.json

# NPX functions
tsc := node_modules/.bin/tsc
ts_node := node_modules/.bin/ts-node
mocha := node_modules/.bin/mocha

# Image
redis_tag := redis-test

.IGNORE: clean-linux kill stop

main: run

dev:
	@echo "[INFO] Building for development"
	@NODE_ENV=development $(tsc) --p $(dev)

run: dev
	@echo "[INFO] Starting"
	@NODE_ENV=development \
	node app/index.js

kill:
	@echo "[INFO] Killing docker image"
	@docker kill $(redis_tag)

stop: kill
	@echo "[INFO] Stopping docker image"
	@docker rm $(redis_tag)

redis:
	@echo "[INFO] Running redis with Docker"
	@docker run -it -p 6379:6379 --name $(redis_tag) redis:latest
