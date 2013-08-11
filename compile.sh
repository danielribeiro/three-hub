#!/usr/bin/env bash
echo Watching changes in coffee
rm -rf ./lib/*
coffee -w -o lib/ -c coffee/

