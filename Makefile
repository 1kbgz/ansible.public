setup:  ## install required dependencies
	pip install ansible ansible-lint

ansible-lint:  ## run linter with ansible-lint
	ansible-lint roles/

check-deps:  ## check that we haven't emptied dependencies for testing
	bash -c 'grep -rn "dependencies: \[\]" ./roles/ | grep -v "remove"'
	bash -c '[[ "$$(grep -rn "dependencies: \[\]" ./roles/ | grep -v "remove" | wc -l | xargs | tee >(cat 1>&2))" == "1" ]]'

lint: check-deps ansible-lint  ## run linters

# Thanks to Francoise at marmelab.com for this
.DEFAULT_GOAL := help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

print-%:
	@echo '$*=$($*)'

.PHONY: help setup ansible-lint check-deps lint help
