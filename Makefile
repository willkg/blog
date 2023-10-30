VENVDIR=./venv
PYTHONVERSION := $(shell python --version)

.DEFAULT_GOAL := help
.PHONY: help
help:
	@echo "Usage: make RULE"
	@echo ""
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' Makefile \
		| grep -v grep \
	    | sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1\3/p' \
	    | column -t  -s '|'

venv:
	@echo ">>> Using $(PYTHONVERSION)"
	@echo ">>> Creating venv $(VENVDIR)"
	python -m venv $(VENVDIR)
	@echo ">>> Upgrading pip"
	${VENVDIR}/bin/python -m pip install --upgrade pip
	${VENVDIR}/bin/python -m pip --version
	# @echo ">>> Installing pip-tools"
	# ${VENVDIR}/bin/python -m pip install pip-tools
	@echo ">>> Installing requirements"
	${VENVDIR}/bin/python -m pip install -r requirements.txt

.PHONY: status
status:  ## | List status
	@echo $(PYTHONVERSION)

.PHONY: clean
clean:  ## | Clean the project
	rm -rf venv
	rm -rf output
	find -name __pycache__ | xargs rm -rf
	find -name '*.pyc' | xargs rm -rf

.PHONY: buildvenv
buildvenv: venv  ## | Build a virtual environment
	echo "Done!"

.PHONY: rebuildreqs
rebuildreqs: venv  ## | Rebuild the requirements.txt file
	${VENVDIR}/bin/pip-compile --generate-hashes

.PHONY: compile
compile: venv  ## | Compile blog
	-mkdir output
	${VENVDIR}/bin/nikola build -a

.PHONY: view
view: venv  ## | View blog
	xdg-open output/index.html

.PHONY: draft
draft: venv  ## | Compile and update whenever the rst file changes
	${VENVDIR}/bin/nikola auto -b
