SOURCE_FIELS = specs.vh alu.v pipeline.v test.v tools.v 

.PHONY: dev-build
dev-build:
	docker compose build veridev

.PHONY: dev
dev:
	docker compose up veridev

.PHONY: test_all
test_all:
	iverilog -g2012 -o run $(SOURCE_FIELS)
	vvp run

.PHONY: context # handy for loading to prompt
context:
	./compose.sh $(SOURCE_FIELS) -o context