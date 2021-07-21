#!/bin/bash

#download the site with searched game (only the first page cause cant be bothered)
curl -s "https://1337x.to/sort-category-search/FitGirl%20$1/Games/seeders/desc/1/" | 

#extract links from html
pup 'table a json{}' |
jq -r '.[].href' |
grep -v "\/user\/FitGirl\/" | 
tac | sed '/\/sub.*/d;/\/user\//,+1 d' | tac | 
sed -e 's/^/https\:\/\/1337x\.to/' |
#get rid of newline at the end
perl -pe 'chomp if eof'
