emsdk-install-latest:## emsdk-install-latest
	@./emsdk install latest
emsdk-activate-latest:## emsdk-activate-latest
	@./emsdk activate latest
emsdk-source-emsdk_env-sh:## emsdk-source-emsdk_env-sh
	. emsdk_env.sh && export PATH
	  echo 'source "/Volumes/git/emsdk/emsdk_env.sh"' >> $(HOME)/.bash_profile
