CLEAN:clean-all ## clean.mk
clean:## clean	project artifacts
	rm -rf *.js
	rm -rf *.wasm
	rm -rf *.html
	rm -rf $(find . -name package-lock.json)
	rm -rf $(find . -name yarn.lock)
clean-nvm: ## clean-nvm
	@rm -rf ~/.nvm
clean-all: clean clean-nvm ## clean-all
	@rm -rf $(find . -name node_modules)