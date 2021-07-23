#!/bin/bash

#exclude scripts that you don't wanna run
exclude=( "example.sh" );

dir="$(pwd)";
#run all scraping scripts in scripts directory and put the results into array
cd "$(dirname "$0")"/scripts || exit;

arg="$1";

#loops through all .sh files in directory
for i in *.sh; do
    #loops through array of excluded items and if any element matches a script name it won't execute
    for y in "${exclude[@]}"
    do
        if [ "$i" != "$y" ]
        then
            #parse output of whatever script gets run into json
            jq --arg script "$i" -Rs '{($script):split("\n")}' < <(sh "$i" "$arg");
        fi
    done
done

cd "$dir" || exit


