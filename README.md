# link-scrape

The only package you need for this script to work is jq, the three scraping scripts I included need these packages (maybe im missing something and you figure out how to install them yourself, if you are using arch all of the packages are in aur): "curl, https://github.com/ericchiang/pup, perl, selenium and python".

On arch you can install dependencies via:
```bash
sudo pacman -Syu curl git jq perl python python-selenium
```

On ubuntu (didn't test):
```bash
sudo apt install curl git jq perl python3 python3-selenium
```

And then also install pup using your aur helper of choice (if on arch) or by building it from source.

Clone the repository:
```bash
git clone https://github.com/reggiiie/link-scrape.git
```

Download chromedriver from here if you wish to use selenium https://sites.google.com/a/chromium.org/chromedriver/downloads.

After that edit the scraper scripts, you only need to edit rin.py and rin.sh, the other scripts work without any changes.

In search.sh you should specify the path to the script directory, it will run every file with .sh at the end and put their output into json.

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
