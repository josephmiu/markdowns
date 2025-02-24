#! /bin/bash

cd /home/miu7898/coding/markdowns
git add .
git commit -m "Auto-sync Update: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main
