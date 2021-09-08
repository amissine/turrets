#!/usr/bin/env bash

# Remove ALL existing turrets.
rm -rf TURRET*

# Export all variables from .env file to the current process env.
export $(cat .env|tr -d \"[:blank:]\"|xargs)

# Configure initial set of turrets.
while [ $(( $TURRETS_COUNT_INIT )) -gt 0 ]; do
  TURRET="TURRET$TURRETS_COUNT_INIT"
  echo "- TURRET $TURRET"
  mkdir $TURRET
  cd $TURRET

  cat ../.env-turret.dist | sed "s/{{ name }}/turret$TURRETS_COUNT_INIT/g" > ./.env.dist
  npx envdist

  cd -
  TURRETS_COUNT_INIT=$(( $TURRETS_COUNT_INIT -1 ))
done
