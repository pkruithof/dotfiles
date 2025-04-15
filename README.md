# My dotfiles

## About

This is my collection of dotfiles. There are many like it but this one is mine.

It does the following:

* configures zsh shell
* installs antidote as plugin manager
* installs some useful zsh plugins
* sets up powerlevel10k prompt
* sets up configuration files for various programs like git, curl, ssh, etc.
* includes optional macOS configuration


## ⚠️ CAUTION ⚠️
**NOT INTENDED FOR OTHERS!**

I use this repository for myself. While you are free to use it, or fork it, it is in no way intended as a general tool for all to use. It may break your setup, or change it in a way you don't like. Use at your own risk.


## Installation

### One line install
This will download a shell script that clones the repository into `~/dotfiles`.

```bash
bash -c "$(curl -fsSL raw.github.com/pkruithof/dotfiles/main/bootstrap)"
```

### Using Git
You can manually checkout the repo if you want to, and run the install script afterwards.

```bash
git clone https://github.com/pkruithof/dotfiles.git ~/.dotfiles && ~/.dotfiles/bin/dotfiles
```

## How to update
You should run the update when:

* You want to pull changes from the remote repository.
* You want to update Homebrew formulae and other dependencies.

Run the dotfiles command (it should be part of your `$PATH` after installation):

```sh
dotfiles [--skip=<update|dependencies>]
```

## Acknowledgements
Thanks to:

* [Mathias Bynens](http://mathiasbynens.be) for (probably without knowing) letting me copy me his [collection of dotfiles](https://github.com/mathiasbynens/dotfiles)
