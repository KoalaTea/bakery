#!/usr/bin/env bash

git clone https://github.com/solo-io/packer-builder-arm-image
cd packer-builder-arm-image
go mod download
go build
