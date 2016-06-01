#!/usr/bin/env bash

homesteadRoot=~/.homestead

mkdir -p "$homesteadRoot"

cp -i src/stubs/Homestead.yaml "$homesteadRoot/Homestead.yaml"
cp -i src/stubs/after.sh "$homesteadRoot/after.sh"
cp -i src/stubs/aliases "$homesteadRoot/aliases"

echo "Homestead initialized!"

echo "AAAAH: Further steps found in init.bat needed! You may create a pull request ;)"