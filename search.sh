#!/bin/bash

#exclude scripts that you don't wanna run
exclude=("rin.sh");

dir="$(pwd)";
#cd into scripts directory
cd "$(dirname "$0")"/scripts || exit 1;

#check if there are any arguments left
argCheck() {
    if [ "$#" -eq 0 ]
    then
        printf "%s %s: not enough arguments supplied\n" "$0" "$stage";
        cd "$dir" || exit 1;
        exit 1;
    fi
}

#checks if there are any arguments
argCheck "$@";

#loops until there are no more arguments
while [ $# -gt 0 ]
do
    case "$1" in
        #print help and exit
        -h|--help)
            printf "Usage: search.sh [FLAGS AND THEIR ARGUMENTS] [SEARCH QUERY]\n\nFlags:\n  -h or --help - show this message\n  -e or --exclude - add script names that shouldn\'t run (separate multiple scripts with commas)\n\n";
            exit 0;
        ;;
        -e|--exclude)
            stage="$1";
            shift;
            
            #check if there is any argument after flag
            argCheck "$@";
                                  
            IFS=', ' read -r -a files <<< "$1"
            for file in "${files[@]}"
            do
                #if file doesn't contain .sh add it making arguments like "gog-games" viable
                if [[ "$file" != *.sh ]]
                then
                    file="$file.sh"
                fi
                
                #checks if script exists
                if [[ -f "$file" ]]
                then
                    #if exists add it to the exclude list
                    exclude+=("$file");
                else
                    #if doesn't exist print error and exit
                    printf '%s %s: \"%s\" not found in the script directory\n' "$0" "$stage" "$file";
                    exit 1;
                fi
            done
            shift;
        ;;
        *)
            break;
        ;;
    esac
done

argCheck "$@";
arg="$1";

#loops through all .sh files in directory
for i in *.sh; do
    #loops through array of excluded items and if any element matches a script name it won't execute
    for y in "${exclude[@]}"
    do
        if [ "$i" = "$y" ]
        then
            continue 2;
        fi
    done
    #parse output of whatever script gets run into json
    jq --arg script "$i" -Rs '{($script):split("\n")}' < <(sh "$i" "$arg");
done

cd "$dir" || exit 1