hello-js:## hello-js
	$(EMCC) hello.c -o hello.js
node-hello-js:hello-js## node-hello-js
	@$(EMSDK_NODE) hello.js
node-hello-html:node-hello-js## node-hello-html
	@$(EMCC) hello.c -O3 -o hello.html
