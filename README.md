# link-scrape

## Usage
```bash
#don't forget to make sure the script is executable by running "chmod +x search.sh"
./search.sh [search query]
```

## Setup
The only package you need for this script to work is jq, the three scraping scripts I included need these packages (maybe im missing something and you figure out how to install them yourself, if you are using arch all of the packages are in aur): "curl, https://github.com/ericchiang/pup, perl, selenium and python".

On arch you can install dependencies via:
```bash
sudo pacman -Syu curl git jq perl python python-selenium
```

On ubuntu:
```bash
sudo apt install curl git jq perl python3 python3-selenium
```

Pup binary is included in the folder so you dont have to build it but you can also also install it using your aur helper of choice (if on arch) or by building it from source https://github.com/ericchiang/pup in which case you will have to edit the scripts to use the pup you installed.

Clone the repository:
```bash
git clone https://github.com/reggiiie/link-scrape.git
```

Download chromedriver from here if you wish to use the python script https://sites.google.com/a/chromium.org/chromedriver/downloads, otherwise just rename rin.sh so it doesn't contain .sh and won't try to execute.

After that edit rin.py and follow comments inside, rin.sh has relative path pointing to rin.py so edit it to full path in case it doesn't work.

Search.sh contains a relative path to script directory (if it doesn't work try specifying it), it will run every file with .sh at the end and put their output into json.

It doesnt matter how the scraping scripts work, the only requirement is for them to outupt lines containing url as whatever the script outputs will be added to the output so if you make your own script it will work as long as the output follows this pattern:
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
