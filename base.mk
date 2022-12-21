init:## init
#	@["$(shell $(SHELL))" == "/bin/zsh"] && zsh --emulate sh
ifeq (EMSDK,)
	$(MAKE) emsdk-all
endif
	@pushd scripts && ./initialize && popd
	@pushd .       && $(PACKAGE_MANAGER) && popd

.PHONY:install
install:init## make init install $(PACKAGE_MANAGER) install
	$(MAKE) init && $(PACKAGE_MANAGER) install
.PHONY:build
build:## build
	#@pushd ./scripts && $(PACKAGE_MANAGER) run build && popd
	@echo "make build stub"
	#@pushd . && $(PACKAGE_MANAGER) run build && popd
.PHONY:preview
preview:## preview
	@$(PACKAGE_MANAGER) run preview
	@node .output/server/index.mjs
.PHONY:dev
dev:## dev
	@$(PACKAGE_MANAGER) run dev
rebuild:## rebuild
	@$(PACKAGE_MANAGER) run rebuild

burnthemall:## burnthemall - hard reset & build
	@cd ./scripts && $(PACKAGE_MANAGER) $(PACKAGE_INSTALL) burnthemall
release:## release - build distribution
	@cd ./scripts && $(PACKAGE_MANAGER) $(PACKAGE_INSTALL) release

help:## help
	@echo ''
	#NOTE: 2 hashes are detected as 1st column output with color
	@sed -n 's/^##ARGS//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
	# @sed -n 's/^.PHONY//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'
	@sed -n 's/^# //p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/# /'
	@sed -n 's/^## //p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/## /'
	@sed -n 's/^### //p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/### /'
	@echo ""
	@echo ""
	@echo ""
	@echo "Useful Commands:"
	@echo ""
	@echo "make install init build"
	@echo "make start"
	@echo "make release"
	@echo ""
	@echo ""

report:## report					environment args
	@echo ''
	@echo ' TIME=${TIME}	'
	@echo ' CURRENT_PATH=${CURRENT_PATH}	'
	@echo ' THIS_DIR=${THIS_DIR}	'
	@echo ' PROJECT_NAME=${PROJECT_NAME}	'
	@echo ''
	@echo ' NODE_VERSION=${NODE_VERSION}	'
	@echo ' NODE_ALIAS=${NODE_ALIAS}	'
	@echo ' EMSDK=${EMSDK}	'
	@echo ' EMSDK_NODE=${EMSDK_NODE}	'
	@echo ' EMSDK_PYTHON=${EMSDK_PYTHON}	'
	@echo ' EMCC=${EMCC}	'
	@echo ''
	@echo ' POWERSHELL=${POWERSHELL}	'
	@echo ''
	@echo ' PACKAGE_MANAGER=${PACKAGE_MANAGER}	'
	@echo ' PACKAGE_INSTALL=${PACKAGE_INSTALL}	'
	@echo ''
	@echo ' PYTHON=${PYTHON}'
	@echo ' PYTHON2=${PYTHON2}'
	@echo ' PYTHON3=${PYTHON3}'
	@echo ''
	@echo ' NODE_GYP_FORCE_PYTHON=${NODE_GYP_FORCE_PYTHON}'
	@echo ' PYTHON_VERSION=${PYTHON_VERSION}'
	@echo ' PYTHON_VERSION_MAJOR=${PYTHON_VERSION_MAJOR}'
	@echo ' PYTHON_VERSION_MINOR=${PYTHON_VERSION_MINOR}'
	@echo ' PIP=${PIP}'
	@echo ' PIP2=${PIP2}'
	@echo ' PIP3=${PIP3}'
	@echo ''
	@echo ' GIT_USER_NAME=${GIT_USER_NAME}	'
	@echo ' GIT_USER_EMAIL=${GIT_USER_EMAIL}	'
	@echo ' GIT_SERVER=${GIT_SERVER}	'
	@echo ' GIT_PROFILE=${GIT_PROFILE}	'
	@echo ' GIT_BRANCH=${GIT_BRANCH}	'
	@echo ' GIT_HASH=${GIT_HASH}	'
	@echo ' GIT_PREVIOUS_HASH=${GIT_PREVIOUS_HASH}	'
	@echo ' GIT_REPO_ORIGIN=${GIT_REPO_ORIGIN}	'
	@echo ' GIT_REPO_NAME=${GIT_REPO_NAME}	'
	@echo ' GIT_REPO_PATH=${GIT_REPO_PATH}	'

#.PHONY:
#phony:
#	@sed -n 's/^.PHONY//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: command
command: executable ## command		example
	@echo "command sequence here..."

.PHONY: executable
executable: ## executable
	chmod +x ./scripts/initialize
.PHONY: exec
exec: executable ## exec	make shell scripts executable

.PHONY: nvm
.ONESHELL:
nvm: executable ## nvm
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash || git pull -C $(HOME)/.nvm && export NVM_DIR="$(HOME)/.nvm" && [ -s "$(NVM_DIR)/nvm.sh" ] && \. "$(NVM_DIR)/nvm.sh" && [ -s "$(NVM_DIR)/bash_completion" ] && \. "$(NVM_DIR)/bash_completion"  && nvm install $(NODE_VERSION) && nvm use $(NODE_VERSION)
	@source ~/.bashrc && nvm alias $(NODE_ALIAS) $(NODE_VERSION)

.PHONY: all
all:- executable install init build emsdk-all ## all - executable install init build emsdk-all
	@echo "make init install build release"

.PHONY: submodule submodules
submodule: submodules ## submodule
submodules: ## submodules
	git submodule update --init --recursive
	git submodule foreach 'git fetch origin; git checkout $$(git rev-parse --abbrev-ref HEAD); git reset --hard origin/$$(git rev-parse --abbrev-ref HEAD); git submodule update --recursive; git clean -dfx'

.PHONY: venv
venv:## create python3 virtualenv .venv
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip install -r requirements.txt; \
	);
	@echo "To activate (venv)"
	@echo "try:"
	@echo ". .venv/bin/activate"
	@echo "or:"
	@echo "make test-venv"
##:	test-venv            source .venv/bin/activate; pip install -r requirements.txt;
test-venv:## 	test virutalenv .venv
	# insert test commands here
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip install -r requirements.txt; \
	);

clean: ## clean
	rm -rf *.js
	rm -rf *.wasm
	rm -rf *.html
	rm -rf $(find . -name package-lock.json)
	rm -rf $(find . -name yarn.lock)
clean-nvm: ## clean-nvm
	@rm -rf ~/.nvm
clean-all: clean clean-nvm ## clean-all
	@rm -rf $(find . -name node_modules)

# vim: set noexpandtab:
# vim: set setfiletype make