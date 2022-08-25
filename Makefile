VENVDIR=./.venv

.DEFAULT_GOAL := help
.PHONY: help
help:
	@echo "Usage: make RULE"
	@echo ""
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' Makefile \
		| grep -v grep \
	    | sed -n 's/^\(.*\): \(.*\)##\(.*\)/\1\3/p' \
	    | column -t  -s '|'

.venv:
	python -m venv .venv
	# ${PIP} install pip-tools
	${VENVDIR}/bin/pip install --upgrade pip
	${VENVDIR}/bin/pip install -r requirements.txt

.PHONY: clean
clean:  ## | Clean the project
	rm -rf .venv
	rm -rf output
	find -name __pycache__ | xargs rm -rf
	find -name '*.pyc' | xargs rm -rf

.PHONY: rebuildreqs
rebuildreqs: .venv  ## | Rebuild the requirements.txt file
	${VENVDIR}/bin/pip-compile --generate-hashes

.PHONY: compile
compile: .venv  ## | Compile blog
	mkdir output
	${VENVDIR}/bin/nikola build -a

.PHONY: view
view: .venv  ## | View blog
	xdg-open output/index.html
