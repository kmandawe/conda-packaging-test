SHELL=/bin/bash

ENV_NAME=cpt-38
CONDA_EXE=$(shell which anaconda)
CONDA_BIN=$(shell dirname $(CONDA_EXE))


recreate-env:
	conda env remove -n $(ENV_NAME)
	conda env create -f environment.yml
	CONDA_ROOT=$(which conda)
	echo $(CONDA_ROOT)
	source $(CONDA_BIN)/../etc/profile.d/conda.sh
	conda activate $(ENV_NAME)
	conda info

activate-env:
	conda activate $(ENV_NAME)

update-env:
	conda env update -f environment.yml

build-and-install: recreate-env

conda-root:
	@echo $(CONDA_ROOT)
