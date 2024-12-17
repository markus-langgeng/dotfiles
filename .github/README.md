# My .dotfiles

Welcome to my dotfiles. Here, I'm going to try to explain as best as I can the
softwares that I use and also the keybindings. I also have other repo for other
softwares that I use that I want to separate from my dotfiles. So, I'm going to
link to it whenever it is mentioned here.

## List of the softwares that I use

- OS: [Alpine Linux](https://alpinelinux.org)
- Shell: [ash (Busybox version)](https://busybox.net)
- Window Manager: [dwl](https://codeberg.org/dwl/dwl/) [my build](https://github.com/markus-langgeng/dwl/tree/0.7)
- ~~Desktop Environment~~: -
- Terminal Emulator: [foot](https://codeberg.org/dnkl/foot) and [st](https://github.com/lukesmithxyz/st)
- App Launcher: custom fzf script
- Status Bar: [slstatus](https://tools.suckless.org/slstatus) [my build](https://github.com/markus-langgeng/slstatus)
- Text Editor: [neovim](https://github.com/neovim/neovim/) [my config](https://github.com/markus-langgeng/nvim)
- Browser: [librewolf](https://librewolf.net/) and [firefox](https://www.mozilla.org/en-US/firefox/) with uBlock origin
- PDF Viewer: [zathura](https://pwmt.org/projects/zathura/)
- Image Viewer: [imv](https://sr.ht/~exec64/imv)
- Video Player: [mpv](https://mpv.io/)
- Screenshot: [grim](https://wayland.emersion.fr/grim/) & [slurp](https://wayland.emersion.fr/slurp/)
- Hot Key: [keyd](https://github.com/rvaiya/keyd)
- IME: [fcitx5](https://fcitx-im.org/wiki/Fcitx_5)

## Setup
```sh
git init --bare $HOME/.dotfiles
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
mydotfiles remote add origin git@github.com:markus-langgeng/dotfiles.git
```

## Replication
```sh
git clone --bare --recurse-submodule git@github.com:markus-langgeng/dotfiles.git $HOME/.dotfiles
alias dfs='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

## Configuration
```sh
dfs config status.showUntrackedFiles no
dfs remote set-url origin git@github.com:markus-langgeng/dotfiles.git
```

## Usage
```sh
dfs status
dfs add .bashrc
dfs commit -m 'Add bashrc'
dfs push
```
