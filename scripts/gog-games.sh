#!/bin/bash

#get the search results
curl -s "https://gog-games.com/search/$(printf '%s\n' "$1" | sed -e 's/ /\%20/g')" |

#extract links from html
"$(dirname "$0")"/pup 'div.game-blocks.grid-view a json{}' |
jq -r '.[].href' | 
sed -e 's/^/https\:\/\/gog\-games\.com/' |

#gog-games search results are bad, if they include more than one word 
#sed removes trailing and leading whitespaces and then replaces all remaining spaces with underscores and feeds the output to grep 
grep -Ei "$(printf '%s\n' "$1" | sed 's/^[ \t]*//;s/[ \t]*$//;s/ /\_/;')" |

#get rid of newline at the end
perl -pe 'chomp if eof' 