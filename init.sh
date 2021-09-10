#!/usr/bin/env bash

kvns () {
  wrangler kv:namespace create $1 | awk '$0 ~ /{ binding = "/ {print $7}'
}

get_id () {
  id=$(kvns "$1")
  id=${id#\"}
  id=${id%\"*}
  echo $id
}

get_turret_address () {
  var="TURRET_${TURRETS_COUNT_INIT}_STELLAR_ACCOUNT"
  TURRET_ADDRESS="${!var}"
}

# Remove ALL existing turrets.
rm -rf TURRET*

# Export all variables from parent .env to the current process env.
export $(cat .env|tr -d [:blank:]|xargs)

# Configure initial set of turrets.
while [ $(( $TURRETS_COUNT_INIT )) -gt 0 ]; do
  TURRETS_COUNT_INIT=$(( $TURRETS_COUNT_INIT -1 ))
  TURRET="TURRET_$TURRETS_COUNT_INIT"
  mkdir $TURRET
  cd $TURRET

  get_turret_address
  cat ../.env-turret.dist | sed \
    -e "s/{{ stellar-account }}/$TURRET_ADDRESS/g" \
    -e "s/{{ name }}/turret$TURRETS_COUNT_INIT/g" > ./.env.dist
  npx envdist -f

  # Export all variables from the turret's .env to the current process env.
  export $(cat .env|tr -d [:blank:]|xargs)

  # Generate ./wrangler.toml from ../wrangler.toml.dist and the current process env.
  envsubst < ../wrangler.toml.dist > ./wrangler.toml

  # Add KV namespaces
  export META=$(get_id 'META')
  export TX_FEES=$(get_id 'TX_FEES')
  export TX_FUNCTIONS=$(get_id 'TX_FUNCTIONS')
  envsubst < ../wrangler.toml.dist > ./wrangler.toml

  cd -
done
