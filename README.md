# dotfiles

## Setup

### macOS

* Install Homebrew
* Install fish

  ```shell
  brew install fish
  ```

### Linux

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

### Dependencies

#### Fzf

On macOS:

```shell
brew install fzf
# Run the outputted fzf install command in a fish session
```

On Linux:

```shell
sudo apt-get install fd-find bat
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

#### Fisher

Run `fisher_update.fish` to install fisher. Fisher will automatically
self-update and install all the dependencies in the correct directory.

#### Delta

Delta is a better Git diff engine, and can be installed through Linuxbrew:

```shell
brew install git-delta
```

#### jEnv (optional)

```shell
brew install jenv
```
