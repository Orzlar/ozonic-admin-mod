#!/bin/bash
echo `git rev-list HEAD --count` > lua/version.lua
git add lua/version.lua