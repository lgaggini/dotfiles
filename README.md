# dotfiles
#### by lgaggini

## README
These are configuration files for my GNU/Linux toolboox:

* shell: `bash`
* terminal: `urxvt`
* terminal multiplexer: `tmux + byobu + tmuxp`
* wm: `awesome`
* editor: `vim`
* file manager: `ranger`
* file manager gui: `pcmanfm`
* email: `mutt` + `notmuch` + `msmtp` + `lbdb` + `offlineimap`
* email gui: `thunderbird` + `muttator`
* pim: `khal` + `todoman` + `davmail` + `vdirsyncer`
* pim gui: `thunderbird` + `lightning`
* wiki/notes: `vim` + some wrapper bash functions
* feed: `newsboat` + `w3m` + [custom script](https://gist.github.com/lgaggini/f0d0e119a0ab4410943dd227370f6fe6)
* ide: `vim`
* ide gui: `gvim`
* versioning: `git`
* music: `mpd` + `mpc` + `ncmpc`
* music gui: `sonata`
* browser: `w3m`
* surfer: `surfraw` + `w3m` + [custom script](https://gist.github.com/lgaggini/f0d0e119a0ab4410943dd227370f6fe6)
* password manager: `pass`
* password manager gui: `qtpass`
* personal finance: `ledger`
* document viewer:  `zathura`
* backup: `restic`

There are many [available solutions](http://dotfiles.github.com/) to manage dotfiles. I use a very simple approach. I have a dedicated folder repo, dotfiles, where i copy manually every files to track. After the first manually copy, i sync my dotfiles by `--existing` options of `rsync`, that syncs two folder only for files present in the destination. In my bash functions i have the function dots:

    rsync -a -v --existing /home/lorenzo/ /home/lorenzo/code/dotfiles/

When on a new machine i clone my github dotfiles repository and copy manually configuration files in the right place.
That's all, no much automation but very simple.

## LICENSE
Feel free to use, fork, modify and share it as you want.
[Creative Commons Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)](https://creativecommons.org/licenses/by-sa/3.0/)
