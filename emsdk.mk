EMSDK:emsdk-all### COMMANDS
#emsdk-four:	### ####
emsdk-all:## emsdk-all
	@$(MAKE) emsdk-install-latest
	@$(MAKE) emsdk-activate-latest
	@$(MAKE) emsdk-source-emsdk_env-sh
emsdk-install-latest:## emsdk-install-latest
	@./emsdk install latest
emsdk-activate-latest:## emsdk-activate-latest
	@./emsdk activate latest
emsdk-source-emsdk_env-sh:## emsdk-source-emsdk_env-sh
	source emsdk_env.sh && export PATH
	  echo 'source "/Volumes/git/emsdk/emsdk_env.sh"' >> $(HOME)/.bash_profile
