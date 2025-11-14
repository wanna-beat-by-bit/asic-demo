.PHONY: dev-build
dev-build:
	docker compose build verilogdev

.PHONY: dev
dev:
	docker compose up verilogdev

.PHONY: test_all
test_all:
	iverilog -g2012 -o run specs.vh alu.v pipeline.v test.v tools.v 
	vvp run