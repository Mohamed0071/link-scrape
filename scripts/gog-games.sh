#!/bin/bash

#get the search results
curl -s "https://gog-games.com/search/$(printf '%s\n' "$1" | sed -e 's/ /\%20/g')" |

#extract links from html
"$(dirname "$0")"/pup 'div.game-blocks.grid-view a json{}' |
jq -r '.[].href' | 
sed -e 's/^/https\:\/\/gog\-games\.com/' |
#get rid of newline at the end
perl -pe 'chomp if eof'
