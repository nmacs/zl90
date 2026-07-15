.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

GID = $(shell id -g $(USER))
UID = $(shell id -u)

OPENWRT := $(CURDIR)/openwrt
OPENWRT_OUTPUT := $(OPENWRT)/openwrt/bin/targets/zixlink-zl90/

MAJOR        ?= 1
MINOR        ?= 0
BUILD_NUMBER ?= 0

VERSION_NUMBER := $(MAJOR).$(MINOR).$(BUILD_NUMBER)
VERSION_REPO   := https://downloads.openwrt.org/releases/24.10.0

DOCKER := docker run --rm --user=$(UID):$(GID) -v "$(CURDIR):/src" --network host -t ubuntu-zixlink-zl90:20.04

.PHONY: build
build:
	make -j13 -C $(OPENWRT)

.PHONY: build_in_docker
build_in_docker:
	$(DOCKER) make -j13 MAJOR=$(MAJOR) MINOR=$(MINOR) BUILD_NUMBER=$(BUILD_NUMBER) -C /src

.PHONY: docker
docker:
	$(MAKE) build -C $(CURDIR)/docker

.PHONY: prepare
prepare:
	cd $(OPENWRT); scripts/feeds update
	cd $(OPENWRT); scripts/feeds install -a

.PHONY: config
config: $(CURDIR)/config/zixlink-zl90_defconfig
	cp $< $(OPENWRT)/.config
	make -C $(OPENWRT) defconfig

.PHONY: clean
clean:
	make -C $(OPENWRT) clean
	make -C $(OPENWRT) dirclean
	rm -rf $(OPENWRT)/build_dir
	rm -rf $(OPENWRT)/bin
