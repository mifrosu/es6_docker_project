NAME = mos_dev_js_node
VERSION = ruby2.2

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .
