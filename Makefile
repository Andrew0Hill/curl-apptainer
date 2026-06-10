# If running on Linux, compile directly. Otherwise, use docker.
ifeq ($(OS), Windows_NT)
	BUILD_OS := Windows
else
	BUILD_OS := $(shell uname -s)
endif

# Directory for built .sifs
BUILD_DIR := build

# Find all .def files.
DEFS := $(shell find . -name '*.def')

# List of .sif outputs.
SIFS := $(DEFS:.def=.sif)

# Build all
all: $(SIFS)

# Each container is built using Apptainer
%.sif: %.def
ifeq ($(BUILD_OS), Linux)
	apptainer build $< $@
else
	cd $(dir $<) && docker run --rm --volume .:/build andrew2hill/container_builder --def
endif

# Clean 
.PHONY : clean
clean: 
	rm $(SIFS)