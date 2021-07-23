#!/bin/bash

#download the site with searched game (only the first page cause can't be bothered)
curl -s "https://1337x.to/sort-category-search/FitGirl%20$(printf '%s\n' "$1" | sed -e 's/ /\%20/g')/Games/seeders/desc/1/" | 

#extract links from html
"$(dirname "$0")"/pup 'table a json{}' |
jq -r '.[].href' |

#you can add more patterns for more users aside from fitgirl, this will remove all links with said users from pipeline
grep -v "\/user\/FitGirl\/" | 

#reverse the output; remove useless links like "/sub/..."; remove links containing any user and 1 line right below them
#since we removed /user/FitGirl/ the links from her won't have a user above them and thus won't be removed; reverse back
tac | sed '/\/sub.*/d;/\/user\//,+1 d' | tac | 

#change relative links to whole links
sed -e 's/^/https\:\/\/1337x\.to/' |
#get rid of newline at the end
perl -pe 'chomp if eof'

