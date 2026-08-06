# dotfiles

## Setup

### Install dependencies

#### macOS

* Install Homebrew
* Install fish

  ```shell
  brew install fish
  ```

* Install stow

  ```shell
  brew install stow
  ```

#### Linux

* Install fish

  ```shell
  sudo apt-add-repository ppa:fish-shell/release-4
  sudo apt update
  sudo apt install fish
  ```

* Install Linuxbrew

  ```shell
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

  ```shell
  sudo apt-get install fd-find bat
  ```

#### Brew packages

```shell
brew install git-delta zoxide eza jenv fnm fzf
```

No shell integration step is needed for fzf: `conf.d/10-fzf.fish` sources
`fzf --fish`, which the binary emits itself, so it works the same on macOS and
Linux and always matches the installed version.

### Set up dotfiles

This assumes the repository is cloned to `~/dotfiles` and that you are starting in `~`.

```shell
cd dotfiles
stow .
fish fisher_update.fish
fish configure_tide.fish
```

### tmux plugins

`.tmux.conf` clones TPM itself on first run, so there is normally nothing to do.
On a brand new machine the clone finishes but the plugin install does not complete
before tmux finishes reading the config, so press `prefix + I` (or `prefix + r`)
once in that first session.

If the automatic clone fails, for instance with no network, install it by hand:

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Machine-specific config

Nothing machine-specific belongs in tracked files. The local overrides are:

| File | Holds |
|------|-------|
| `~/.gitconfig.local` | git identity and anything with an absolute path |
| `~/.config/fish/conf.d/_local.fish` | shell settings for this machine only |

`~/.gitconfig` includes `~/.gitconfig.local` if it exists and ignores it if not,
so the tracked default identity applies until you override it.
