.PHONY: help
help: ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Deployment

.PHONY: update-nebullvm
update-nebullvm: ## Update the nebullvm sub-module to the latest commit on `main`
	@ git submodule update --remote ./nebullvm

.PHONY: update-nos
update-nos: ## Update the nos sub-module to the latest commit on `main`
	@ git submodule update --remote ./nos

.PHONY: update
update: update-nebullvm update-nos ## Update all the nos sub-modules to the latest commit on `main`

##@ Development

.PHONY: serve
serve: ## Start a local web server for serving documentation
	@ mkdocs serve || echo "Error running mkserve. Have you run make install?"

.PHONY: install
install: ## Install the requirements for starting the local web server for serving docs
	@ pip install -r requirements.txt
