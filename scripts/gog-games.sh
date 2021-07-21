#!/bin/bash

#get the search results
curl -s "https://gog-games.com/search/$1" |

#extract links from html
pup 'div.game-blocks.grid-view a json{}' |
jq -r '.[].href' | 
sed -e 's/^/https\:\/\/gog\-games\.com/' |
#get rid of newline at the end
perl -pe 'chomp if eof'