#!/bin/bash

#array of cs.rin.ru board names to output
boardList=( "Main Forum" "Archive" "Releases" "Steam Content Sharing" "Other Gaming Platforms" );

#scrape using selenium because javascript (might take a minute) and parse the output into json and parse the output 
json=""
json="$(python "$(dirname "$0")"/rin.py "$1" | "$(dirname "$0")"/pup 'table.tablebg a json{}' | jq '(del(.[].children)) | .[] | select(.text)' | jq -s '.' | jq '. | to_entries | .[]')"

#loop through the whole json and extract links with some other information
for (( i=0; i <= "$(printf '%s\n' "$json" | jq '.key' | tac | sed -n '1p')"; i++))
do
    #get the link and the title from the element in "key: i"
    title="$(printf '%s\n' "$json" | jq -r --argjson n "$i" '. | select(.key==$n) | .value | select(.class=="topictitle") | .href, .text' | sed ' 1 s/.*/& \-/' | tr '\n' ' ')";

    #I just realized the following two loops could be put into one but that's for some other time

    #if object at "key: i" contains something get the text from element at "key: (i+1)"" (the board name)
    if [ -n "$title" ] 
    then
        i=$((i+1));
        board="$(printf '%s\n' "$json" | jq -r --argjson n "$i" '. | select(.key==$n) | .value | .text')";    
    fi

    #if the board name ends up being a number we need to loop through a few more elements until we find something that is a word
    re='^[0-9]+$'
    while [[ $board =~ $re ]]
    do
        i=$((i+1));
        board="$(printf '%s\n' "$json" | jq -r --argjson n "$i" '. | select(.key==$n) | .value | .text')";
    done

    #if board name equals one of the matches it prints it, otherwise it is discarded alongside the corresponding name and link
    for b in "${boardList[@]}"
    do
        if [ "$board" = "$b" ]
        then
            printf '%s- %s\n' "$title" "$board";
        fi
    done      
    board='';
done |

#make the output a full url and remove trailing newline
sed -e 's/^.//;s/^/https\:\/\/cs\.rin\.ru\/forum/;s/\&amp\;/\&/g' |
perl -pe 'chomp if eof'

