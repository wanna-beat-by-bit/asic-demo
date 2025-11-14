SOURCE_FILES = specs.vh alu.v pipeline.v test.v tools.v 

run: $(SOURCE_FILES)
	iverilog -g2012 -o run $(SOURCE_FILES)

context: $(SOURCE_FILES)
	./compose.sh $(SOURCE_FILES) -o context

.PHONY: test_all

test_all: run
	vvp run

