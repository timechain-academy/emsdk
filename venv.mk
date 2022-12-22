VENV:venv-install venv-test### venv.mk
#venv-four:   ### ####        
.PHONY: venv-install
venv-install:## create python3 virtualenv .venv
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip install -r requirements.txt; \
	);
	@echo "To activate (venv)"
	@echo "try:"
	@echo ". .venv/bin/activate"
	@echo "or:"
	@echo "make test-venv"
##:	test-venv source .venv/bin/activate; pip install -r requirements.txt;
venv-test:## test virutalenv .venv
	# insert test commands here
	test -d .venv || $(PYTHON3) -m virtualenv .venv
	( \
	   source .venv/bin/activate; pip install -r requirements.txt; \
	);