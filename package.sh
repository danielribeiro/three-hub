#!/usr/bin/env bash
echo Distributing the extension...
rm -rf ./lib/*
coffee -o lib/ -c coffee/
mkdir -p pkg/
zip -r pkg/three-hub.crx . -x '.*/*' '.*' '*.sh' 'coffee/*' 'test/*' 'pkg/*' 
echo Distribution file created at pkg/three-hub.crx
