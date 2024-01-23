#!/bin/bash
set -euo pipefail
rm -rf public/*
hugo
cd public
git add -A
git commit -m "GitHub Pages Build: $(date +%F)"
git push origin main --force
