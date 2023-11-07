container_cmd := /usr/bin/docker
#container_cmd := /usr/bin/podman

mkfile_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

.PHONY: check
check: test

template:
	$(container_cmd) run -ti --rm -v $(mkfile_path):/apps docker.io/alpine/helm:3.11.1 template /apps/spire-flex

test:
	$(container_cmd) run -ti --rm -v $(mkfile_path):/apps docker.io/alpine/helm:3.11.1 lint /apps/spire-flex -f /apps/spire-flex/values.yaml
	$(container_cmd) run -ti --rm -v $(mkfile_path):/apps docker.io/helmunittest/helm-unittest:3.11.1-0.3.0 /apps/spire-flex/ -d -f tests/*.yaml

helm-version:
	$(container_cmd) run -ti --rm -v $(mkfile_path):/apps docker.io/alpine/helm:3.11.1 version

package:
	$(container_cmd) run -ti --rm -v $(mkfile_path):/apps docker.io/alpine/helm:3.11.1 package /apps/spire-flex/

clean:
	rm -f spire-flex-*.tgz

