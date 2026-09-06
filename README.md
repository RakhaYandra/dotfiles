# dotfiles

Omarchy dotfiles, bare git repo (`~/.dotfiles`, work-tree `$HOME`).

## Bootstrap

```sh
git clone --bare https://github.com/RakhaYandra/dotfiles.git "$HOME/.dotfiles"
dotfiles() { git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME" "$@"; }
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

`~/.bashrc` sengaja tidak disentuh — definisikan `dotfiles()` manual per sesi.

```sh
sudo pacman -S --needed - < ~/pkglist-pacman.txt
yay -S --needed - < ~/pkglist-aur.txt
mise install
```

Manual (tidak di-track): `gh auth login`, `~/.ssh`.

## Usage

```sh
dotfiles status
dotfiles add ~/.config/foo/bar.conf
dotfiles commit -m "..."
dotfiles push
```

Refresh pkglist:

```sh
comm -23 <(pacman -Qqe | sort) <(pacman -Qqem | sort) > ~/pkglist-pacman.txt
pacman -Qqem | sort > ~/pkglist-aur.txt
```
