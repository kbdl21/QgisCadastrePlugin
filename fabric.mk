#
# Makefile for building/packaging qgis for lizmap hosting
#

ifndef FABRIC
FABRIC:=$(shell [ -e .fabricrc ] && echo "fab -c .fabricrc" || echo "fab")
endif

VERSION=$(shell python metadata.py metadata.txt version)

main:
	echo "Makefile for packaging infra components: select a task"

PACKAGE=qgis_cadastre
FILES = composers filters forms icons interface scripts styles templates *.py *.qrc icon.png metadata.txt README.md LICENSE


build/cadastre:
	@rm -rf build/cadastre
	@mkdir -p build/cadastre


.PHONY: package
package: build/cadastre
	@echo "Building package qgis_cadastre"
	@cp -rLp $(FILES) build/cadastre/
	$(FABRIC) package:qgis_cadastre,versiontag=$(VERSION),files=cadastre,directory=./build

