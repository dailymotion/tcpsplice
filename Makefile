#!/bin/sh

# build targets
all: tcpsplice

tcpsplice: resources.go *.go
	go get -d && env CGO_ENABLED=0 go build -trimpath -o tcpsplice
	strip tcpsplice 2>/dev/null || true
	upx -9 tcpsplice 2>/dev/null || true
resources.go: scripts/rpack resources/*
	scripts/rpack resources
scripts/rpack: scripts/rpack.go
	@$(MAKE) -C scripts
clean:
distclean:
	@rm -f tcpsplice *.upx resources.go rpack
deb:
	@debuild -e GOROOT -e GOPATH -e PATH -i -us -uc -b
debclean:
	@debuild -- clean
	@rm -f ../tcpsplice_*

# run targets
run: tcpsplice
	@./tcpsplice conf/tcpsplice.conf
