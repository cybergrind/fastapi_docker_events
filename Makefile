PYTHON ?= python3
VENV ?= venv
PY ?= $(VENV)/bin/python
PIP ?= $(VENV)/bin/pip
EXTRA_FLAGS ?= ''
BIN ?= $(VENV)/bin


# need to install pip-tools: pip install -U --user pip-tools
requirements.txt: requirements.in
	pip-compile --upgrade --generate-hashes --output-file=$@ requirements.in

$(PY): requirements.txt
	$(PYTHON) -m venv venv
	$(PIP) install -r requirements.txt

venv: $(PY)

run: venv
	${BIN}/uvicorn --factory app:get_app --host=0.0.0.0 --port=8009

test_client: venv
	${BIN}/python test_client.py
