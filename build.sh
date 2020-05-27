#!/bin/bash
set -e

PROJECT_NAME=cpt
python versioneer.py version
PROJECT_VERSION=$(<VERSION)
ENV_NAME=cpt-38
CONDA_EXE=$(command -v anaconda)
CONDA_BIN=$(dirname "$CONDA_EXE")

echo "************************** 0. Starting Build for Project: $PROJECT_NAME Version: $PROJECT_VERSION **************"

echo "************************** 1. Removing environment: $ENV_NAME **************************************************"
eval "$(conda shell.bash hook)"
conda deactivate
conda env remove -n $ENV_NAME
rm -rf "$CONDA_BIN/../envs/$ENV_NAME"

echo "************************** 2. Creating environment: $ENV_NAME **************************************************"
conda env create -f environment.yml

echo "************************** 3. Activating environment: $ENV_NAME ************************************************"
eval "$(conda shell.bash hook)"
conda activate $ENV_NAME
conda info

echo "************************** 4. Building Conda Recipe for Project: $PROJECT_NAME *********************************"
conda build conda.recipe
conda search -c file://"$CONDA_BIN"/../conda-bld --override-channels $PROJECT_NAME
conda build purge

echo "************************** 5. Installing $PROJECT_NAME=$PROJECT_VERSION to environment: $ENV_NAME ***************"
conda install "$PROJECT_NAME=$PROJECT_VERSION" -y

echo "************************** 6. Packaging whole environment: $ENV_NAME *******************************************"
mkdir -p dist
conda pack -n $ENV_NAME -o "dist/$PROJECT_NAME-$PROJECT_VERSION.tar.gz"

echo "************************** Done Building $PROJECT_NAME-$PROJECT_VERSION *****************************************"