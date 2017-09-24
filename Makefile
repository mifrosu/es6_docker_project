NAME = mos_dev_js_node
VERSION = ruby2.4

.PHONY: all build

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .
