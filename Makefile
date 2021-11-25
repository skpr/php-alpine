ALPINE=3.14
PHP=8.1

BUILD_IMAGE=skpr-abuild:latest

build: image
	# @todo, Make sure keys exist.
	docker container run -it  -v $(CURDIR)/packages:/packages \
                                -v $(CURDIR)/_output/$(ALPINE)/php$(PHP)/x86_64:/_output/packages/x86_64 \
                                $(BUILD_IMAGE) $(PHP)

image:
	docker image build --build-arg ALPINE_VERSION=$(ALPINE) -t $(BUILD_IMAGE) build

PRIVATE_KEY=$(CURDIR)/build/.abuild/skpr.rsa.priv
PUBLIC_KEY=$(CURDIR)/build/.abuild/skpr.rsa.pub

# This is a step which is only used for local development.
keys:
	openssl genrsa -out $(PRIVATE_KEY) 4096
	openssl rsa -in $(PRIVATE_KEY) -pubout -out $(PUBLIC_KEY)

deploy:
	@echo "Not implemented..."

.PHONY: *
