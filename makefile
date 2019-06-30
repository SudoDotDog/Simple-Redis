# Paths
build := typescript/tsconfig.build.json
dev := typescript/tsconfig.dev.json

# NPX functions
tsc := node_modules/.bin/tsc
ts_node := node_modules/.bin/ts-node
mocha := node_modules/.bin/mocha

# Image
redis_tag := redis-test

main: run

dev:
	@echo "[INFO] Building for development"
	@NODE_ENV=development $(tsc) --p $(dev)

run: dev
	@echo "[INFO] Starting"
	@NODE_ENV=development \
	node app/index.js

redis:
	@echo "[INFO] Running redis with Docker"
	@docker run --name $(redis_tag) -d redis -p 6379:6379
