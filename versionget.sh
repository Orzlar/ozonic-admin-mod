#!/bin/bash
echo 'OZA.version = '.`git rev-list HEAD --count` > lua/version.lua
git add lua/version.lua