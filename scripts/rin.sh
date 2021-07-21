#!/bin/bash

#scrape using selenium because javascript (might take a minute)
python "$(dirname "$0")"/rin.py "$1" | 

#extract links
pup 'table.tablebg a json{}' | 
jq -r '(.[] | select(.class=="topictitle")) .href' |
sed -e 's/^.//;s/^/https\:\/\/cs\.rin\.ru\/forum/;s/\&amp\;/\&/g' |
#get rid of newline at the end
perl -pe 'chomp if eof'
