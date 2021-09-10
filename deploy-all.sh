#!/usr/bin/env bash

for d in TURRET_*; do
  cp $d/wrangler.toml .
  npm i && npm run deploy
  rm wrangler.toml
done
