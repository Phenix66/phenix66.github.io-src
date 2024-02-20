#!/bin/bash
set -euo pipefail
rm -rf public/*
hugo --noChmod
cd public
git add -A
git commit -m "GitHub Pages Build: $(date +%F)"
git push origin HEAD:main
