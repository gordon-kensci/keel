JOBDATE		?= $(shell date -u +%Y-%m-%dT%H%M%SZ)
GIT_REVISION	= $(shell git rev-parse --short HEAD)
VERSION		?= $(GIT_REVISION)

LDFLAGS		+= -X github.com/rusenask/keel/version.Version=$(VERSION)
LDFLAGS		+= -X github.com/rusenask/keel/version.Revision=$(GIT_REVISION)
LDFLAGS		+= -X github.com/rusenask/keel/version.BuildDate=$(JOBDATE)

.PHONY: release

test:
	go test -v `go list ./... | egrep -v /vendor/`

build:
	@echo "++ Building keel"
	CGO_ENABLED=0 GOOS=linux go build -a -tags netgo -ldflags "$(LDFLAGS)" -o keel .