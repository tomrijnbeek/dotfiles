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

* Install fzf

  ```shell
  brew install fzf
  # Run the outputted fzf install command in a fish session
  ```

#### Linux

* Install fish

  ```shell
  sudo apt-add-repository ppa:fish-shell/release-3
  sudo apt update
  sudo apt install fish
  ```

* Install Linuxbrew

  ```shell
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```

  * Install fzf

  ```shell
  sudo apt-get install fd-find bat
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
  ```

#### Brew packages

```shell
brew install git-delta zoxide eza jenv fnm
```

### Set up dotfiles

This assumes the repository is cloned to `~/dotfiles` and that you are starting in `~`.

```shell
cd dotfiles
stow .
fish fisher_update.fish
fish configure_tide.fish
```
