# dotfiles
#### by lgaggini

## README
These are configuration files for my GNU/Linux toolboox:

* shell: `bash`
* wm: awesome
* editor: `vim`
* email: `mutt` + `notmuch`
* feed: `newsbeuter`
* ide: `gvim`
* versioning: `git`
* music: `mpd` 
* browser: `w3m`
* surfer: `surfraw`
* password manager: `pwsafe`
* personal finance: `ledger`
* document viewer:  `zathura`

There are many [available solutions](http://dotfiles.github.com/) to manage dotfiles. I use a very simple approach. I have a dedicated folder repo, dotfiles, where i copy manually every files to track. After the first manually copy, i sync my dotfiles by `--existing` options of `rsync`, that syncs two folder only for files present in the destination. In my bash functions i have the function dots:

    rsync -a -v --existing /home/lorenzo/ /home/lorenzo/code/dotfiles/

When on a new machine i clone my github dotfiles repository and copy manually configuration files in the right place.
That's all, no much automation but very simple.

## LICENSE
Feel free to use, fork, modify and share it as you want.
[Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)](https://creativecommons.org/licenses/by-sa/3.0/)
