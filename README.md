# dotfiles

These are configuration files for my GNU/Linux workstation(s), some files for my recently added macOS workstation (`term`, `zsh`, `flashspace`, `sol`, `karabiner`, `neovim`) and for my Windows workstation too (`windows terminal`, `archlinux wsl`,  `zsh`, `komorebi`, `whkd`, `neovim`, `flow-launcher`).

## Toolbox
* shell: `bash + starship`, `zsh + zim` (on macOS/Windows)
* core tools enhancements: `lsd, ripgrep, procs, fzf, zoxide, git-delta, bat, fd, prettyping, duf, tig, bc, curlie`
* terminal: `alacritty`, `term` (on macOS), `windows terminal` (on Windows)
* terminal multiplexer: `tmux`
* wm, workspaces: `awesome`, `flashspace` (on macOS), `komorebi` (on Windows)
* launcher: `rofi`, `sol` (on macOS), `flow-launcher` (on Windows) 
* editor: `neovim + nvchad`
* email: `neomutt`
* feed: `newsboat` + `w3m` + [custom script](https://github.com/lgaggini/dotfiles/blob/master/bin/tmux_splitted_pager.sh)
* ide: `neovim`
* versioning: `git`
* music: `mpd`
* browser: `w3m`
* surfer: `surfraw` + `w3m` + [custom script](https://github.com/lgaggini/dotfiles/blob/master/bin/tmux_splitted_pager.sh)
* password manager: `paas + rofi-pass`, `bitwarden` (on macOS/Windows)
* clipboard manager: `greenclip + rofi`
* backup: `restic`
* irc: `weechat`
* calculator: `rofi-calc`
* snippet-manager: `rofi-snippy` + [custom script](https://github.com/lgaggini/dotfiles/blob/master/bin/rofi-snippy)

## Usage
There are many [available solutions](http://dotfiles.github.com/) to manage dotfiles. I use a very simple approach. I have a dedicated folder repo, dotfiles, where i copy manually every files to track. After the first manually copy, i sync my dotfiles by `--existing` options of `rsync`, that syncs two folder only for files present in the destination. In my bash functions i have the function dots:

    rsync -a -v --existing /home/lg/ /home/lg/code/dotfiles/

When on a new machine I clone my github dotfiles repository and copy manually configuration files in the right place.
That's all, not much automation but very simple.
