# README

## Torch

## TensorFlow

1. download `pathfinder-config.cmake` from main branch of `https://github.com/starlab-unist/pathfinder.git` if it's not included when cloning submodules
2. `docker build -f $PWD/docker/base.Dockerfile -t starlabunist/pathfinder:base .`
3. `docker build -f $PWD/docker/tf2.19-base.Dockerfile -t starlabunist/pathfinder:tf2.19-base .`
4. `docker build -f $PWD/docker/tf2.19-fuzz.Dockerfile -t starlabunist/pathfinder:tf2.19-fuzz .`
5. `python3 -u run.py --dll tf --version 2.19 --mode fuzz > tf2.19.log 2>&1`
