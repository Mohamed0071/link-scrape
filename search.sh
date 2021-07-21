#!/bin/bash

dir="$(pwd)"
#run all scraping scripts in scripts directory and put the results into array
cd "$(dirname "$0")"/scripts || exit

arg="$1"
for f in *.sh; do
    jq --arg script "$f" -Rs '{($script):split("\n")}' < <(sh "$f" "$arg")
done

cd "$dir" 


