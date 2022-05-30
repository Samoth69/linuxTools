#!/bin/bash

# stop le script si une commande plante
set -e

# load venv
source .venv/bin/activate

python3 main.py

deactivate