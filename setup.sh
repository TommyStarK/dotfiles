#!/usr/bin/env bash

# Install Command Line Tools
xcode-select --install

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
brew install gnu-sed --with-default-names
# Install Bash 4.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Copy bash .files to HOME
for file in ./.{aliases,bash_profile,bash_prompt,bashrc,editorconfig,exports,functions,gitconfig,inputrc,paths}; do
	cp -v "$file" ~;
done;
unset file;

# Install various tools
brew install ack
brew install bat
brew install cmake
brew install curl
brew install gawk
brew install gcc
brew install gdb
brew install git
brew install git-lfs
brew install go
brew install grep
brew install htop
brew install lua
brew install mongodb
brew install mysql
brew install nano
brew install node
brew install openssh
brew install p7zip
brew install pigz
brew install pv
brew install python@2
brew install python
brew install redis
brew install rename
brew install rlwrap
brew install screen
brew install ssh-copy-id
brew install tcpdump
brew install tree
brew install wget --with-iri
brew install yarn --without-node
brew install zopfli
brew cask install docker
brew cask install google-chrome
brew cleanup

# Install nano with syntax highlighting
wget https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh -O- | sh

# Install nvm
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# Install Python deps
pip2 install --upgrade pip
pip3 install --upgrade pip
pip3 install -r requirements.txt --upgrade --user

# Install Node modules
npm install -g cors
npm install -g body-parser
npm install -g express
npm install -g mongodb
npm install -g react
npm install -g create-react-app

# Setup MacOs defaults
chmod +x .macos
./.macos

# Reboot
sudo reboot
