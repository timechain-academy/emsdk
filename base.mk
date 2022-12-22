base:### base.mk
#base-four:   ### ####
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

init:
#	@["$(shell $(SHELL))" == "/bin/zsh"] && zsh --emulate sh
ifeq (EMSDK,)
	$(MAKE) emsdk-all
endif
	@pushd scripts && ./initialize && popd
	@pushd .       && $(PACKAGE_MANAGER) && popd

.PHONY:install
install:init## make	init install $(PACKAGE_MANAGER) install
	$(MAKE) init && $(PACKAGE_MANAGER) install
.PHONY:build
build:
	#@pushd ./scripts && $(PACKAGE_MANAGER) run build && popd
	#@pushd . && $(PACKAGE_MANAGER) run build && popd
	@echo "make build stub"
.PHONY:preview
preview:
	@echo "make preview stub"
	#@$(PACKAGE_MANAGER) run preview
	#@node hello.js
.PHONY:dev
dev:
	#@$(PACKAGE_MANAGER) run dev
	@echo "make dev stub"
rebuild:
	#@$(PACKAGE_MANAGER) run rebuild
	@echo "make rebuild stub"

release:
	#@cd ./scripts && $(PACKAGE_MANAGER) $(PACKAGE_INSTALL) release
	@echo "make release stub"

#.PHONY:
#phony:
#	@sed -n 's/^.PHONY//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

.PHONY: command
command: executable ## command	example
	@echo "command sequence here..."

.PHONY: executable
executable:
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

# vim: set noexpandtab:
# vim: set setfiletype make