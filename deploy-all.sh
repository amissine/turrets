#!/usr/bin/env bash

npm i && npm run build
for d in TURRET_*; do
  cd $d
  wrangler publish
  cd -
done
