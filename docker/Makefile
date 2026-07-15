GID = $(shell id -g $(USER))
UID = $(shell id -u)

.phony: run
run:
	docker run -ti --rm --user=$(UID):$(GID)  -v "$(CURDIR)/../:/src" -t ubuntu-zixlink-router:20.04

root:
	docker run -ti --rm  -v "$(CURDIR)/../:/src" -t ubuntu-zixlink-router:20.04

build:
	docker build --build-arg GROUPID=$(GID) --build-arg USERID=$(UID) -t ubuntu-zixlink-router:20.04 .
