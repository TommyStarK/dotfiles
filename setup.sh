# #!/usr/bin/env bash

# Install Command Line Tools
xcode-select --install
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Extends the sudo timeout for another 5 minutes by default
sudo -v

# Use latest Homebrew
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
brew install coreutils
# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install latest version of zsh
brew install zsh

# Switch to using brew-installed zsh as default shell
if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
  echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/zsh;
fi;

# Copy .files to HOME
for file in ./.{aliases,curlrc,editorconfig,exports,functions,gitconfig,paths,screenrc,wgetrc,zshrc}; do
	cp -v "$file" ~;
done;
unset file;

# Copy zsh directory to the home
cp -R .zsh ~

# Install various tools
brew install ack
brew install ansible
brew install argocd
brew install bash-completion
brew install bat
brew install cmake
brew install consul-template
brew install curl
brew install emacs
brew install gawk
brew install gcc
brew install gdb
brew install git
brew install git-delta
brew install git-extras
brew install git-lfs
brew install go
brew install graphviz
brew install grep
brew install htop
brew install jq
brew install kubectl
brew install libpq
brew install lua
brew install mongodb
brew install mysql
brew install nano
brew install node
brew install openssh
brew install p7zip
brew install protobuf
brew install psql
brew install python
brew install redis
brew install rename
brew install screen
brew install ssh-copy-id
brew install tcpdump
brew install terraform
brew install tig
brew install tree
brew install vegeta
brew install watch
brew install wireshark
brew install wget
brew install yarn
brew install zopfli

brew install --cask docker
brew install --cask fly
brew install --cask google-chrome
brew install --cask iterm2
brew install --cask visual-studio-code

brew cleanup

# Install nano with syntax highlighting
wget https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh -O- | sh

# Install nvm
mkdir ~/.nvm && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# Install Python deps
pip3 install --upgrade pip
pip3 install -r requirements.txt

# Install Node modules
npm install -g ts-node

# Setup MacOs defaults
./.macos

# Reboot
sudo reboot
