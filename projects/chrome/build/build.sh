#!/bin/sh

source=../source

version=$(cat $source/manifest.json | grep \"version\": | awk '{print $2}' | sed 's/"//g')
name="tabs_reloader-v$version.zip"

coffee -c $source

zip -j $name $source/*
