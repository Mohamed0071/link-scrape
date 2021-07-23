# link-scrape

## Usage
```bash
#don't forget to make sure the script is executable by running "chmod +x search.sh"
./search.sh [search query]

#example
./search.sh "witcher"
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

Clone the repository and make pup executable so we can use it:
```bash
git clone https://github.com/reggiiie/link-scrape.git && chmod +x link-scrape/scripts/pup
```

Download chromedriver from here if you wish to use the python script https://sites.google.com/a/chromium.org/chromedriver/downloads, otherwise just rename rin.sh so it doesn't contain .sh and won't try to execute.

After that edit rin.py and follow comments inside, rin.sh has relative path pointing to rin.py so edit it to full path in case it doesn't work.

If selenium doesn't work you can try installing it with "sudo pip install selenium" instead of ubuntu repo but idk if that will help, just guessing.

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

## Running Games on Linux
Since this collection of scripts is made to search for game downloads on linux I might as well include a few lines on how to actually run them.

Assuming that you have a working setup with gpu drivers installed most games will run well using steam's compatibility layer called proton, to use it just open steam and click ADD A GAME -> Add a Non-Steam Game... and choose whatever exe you downloaded, then in game properties -> compatibility choose force use of steam compatibility tool and choose a version of proton, also make sure that the shortcut actually points to the game cause steam dislikes spaces in file names and might mess up the path. You might need to go to settings on the upper left corner and enable Steam Play. After that you should probably be able to run your game. You can check how well your games should run on https://www.protondb.com/.

If you have trouble running the game installer you could also run the setup on windows machine or vm and then just copy over the files and add those to steam.

The second option is Lutris that you can install from here: https://lutris.net/downloads/ and install all its dependencies that it needs using this guide: https://github.com/lutris/docs/blob/master/WineDependencies.md. Lutris doesn't give you the option to easily install steam games that you don't own but usually you can just give it gog setup exe and it will install it without issues and it will help you run games that don't work on linux without major tweaks like League of Legends. You can check how well your games should run on https://lutris.net/.
