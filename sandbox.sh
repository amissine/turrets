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

export META=$(get_id 'META')

echo "- META $META"
