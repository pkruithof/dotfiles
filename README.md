# My dotfiles

## About

This is my collection of dotfiles. There are many like it but this one is mine.

It does the following:

* installs zsh as the default shell
* installs zplug as plugin manager
* installs some useful zsh plugins
* sets up pure prompt
* sets up configuration files for various programs like git, curl, ssh, etc.
* performs OS-specific setup


## CAUTION
**NOT FOR BASH USERS!**

I recently switched to zsh as my default shell. Therefore the installation assumes you're using zsh. If you're using bash, chances are your environment could be messed up.

Will overwrite existing dotfiles in your HOME and `.vim` directories. 

Use at your own risk.


## Installation

Installing will clone this repo, and symlink/copy files and directories to your home directory. It also determines the type of system you're using (Linux/OSX) and configures some things specific to that OS.

The installation requires the [XCode Command Line
Tools](https://developer.apple.com/downloads) if you're on a Mac. 

### One line install
This will download a shell script that clones the repository into `~/dotfiles`.

```bash
bash -c "$(curl -fsSL raw.github.com/pkruithof/dotfiles/master/bootstrap)"
```

### Using Git
You can manually checkout the repo if you want to, and run the install script afterwards.

```bash
git clone https://github.com/pkruithof/dotfiles.git ~/.dotfiles && ~/.dotfiles/bin/dotfiles
```

## How to update
You should run the update when:

* You want to pull changes from the remote repository.
* You want to update Homebrew formulae and Node packages.

Run the dotfiles command:

```bash
~/.dotfiles/bin/dotfiles
```

Options:

<table>
    <tr>
        <td><code>--no-packages</code></td>
        <td>Suppress package updates</td>
    </tr>
    <tr>
        <td><code>--no-sync</code></td>
        <td>Suppress pulling from the remote repository</td>
    </tr>
</table>

## TODO
Document local settings

## Acknowledgements
Thanks to:

* [Mathias Bynens](http://mathiasbynens.be) for (probably without knowing) letting me copy me his [collection of dotfiles](https://github.com/mathiasbynens/dotfiles)
