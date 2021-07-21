# link-scrape

The only package you need for this script to work is jq, the three scraping scripts I included need these packages (maybe im missing something and you figure out how to install them yourself, if you are using arch all of the packages are in aur): "curl, https://github.com/ericchiang/pup, perl, selenium and python".

Rin.sh and rin.py will need to be edited to work.

In search.sh you should specify the path to the script directory, it will run every file with .sh at the end and put their output into json.

It doesnt matter how the scraping scripts work, the only requirement is for them to outupt lines containing url as whatever the script outputs will be added to the output.

Example output of script example.sh:
```
https://www.example.com/1
https://www.example.com/2
https://www.example.com/3
```
Search.sh will then output something like:
```json
{
  "example.sh":  [
    "https://www.example.com/1",
    "https://www.example.com/2",
    "https://www.example.com/3"
  ]
}
```
You can then do what you will with this output or edit search.sh to give you a different one.
