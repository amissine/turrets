#!/usr/bin/env bash

TURRET_0_PORT=8787
TURRET_1_PORT=8788
TURRET_2_PORT=8789 # TODO use root dir's .env instead

for d in TURRET_*; do
  var="${d}_PORT"
  ttab -w -d "$PWD/$d" exec "$PWD/dev.sh" "${!var}"
done
rollup -c -w
