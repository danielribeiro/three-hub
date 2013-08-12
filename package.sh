#!/usr/bin/env bash
echo Distributing the extension...
rm -rf ./lib/*
coffee -o lib/ -c coffee/
mkdir -p pkg/
zip -r pkg/three-hub.zip . -x '.*/*' '.*' '*.sh' 'coffee/*' 'test/*' 'pkg/*' 'docs/*'
echo Distribution file created at pkg/three-hub.zip
