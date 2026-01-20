.PHONY: build up down logs test metrics clean

APP_NAME=rocky

build:
	@echo "Building $(APP_NAME)..."
	docker build -t $(APP_NAME) .

up:
	@echo "Starting $(APP_NAME)..."
	docker run -d \
		--name $(APP_NAME) \
		-p 8080:80 \
		$(APP_NAME)

down:
	@echo "Stopping $(APP_NAME)..."
	docker stop $(APP_NAME) || true
	docker rm $(APP_NAME) || true

logs:
	docker logs -f $(APP_NAME)

test:
	@echo "Running tests..."
	curl -f http://localhost:8080/ || (echo "FAILED MAIN PAGE"; exit 1)
	curl -f http://localhost:8080/metrics || (echo "FAILED METRICS"; exit 1)
	@echo "All tests passed!"

metrics:
	@echo "Metrics:"
	@curl -s http://localhost:8080/metrics | head -10