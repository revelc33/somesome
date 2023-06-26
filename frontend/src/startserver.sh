#!/bin/bash
if [ -v BACKEND_DOMAIN ]; then
  sed -i "s/specyal88/$BACKEND_DOMAIN/g" /app/index.html
fi
python3 -m http.server 8000