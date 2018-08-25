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
brew install curl
brew install wget --with-iri
brew install openssh
brew install screen
brew install htop
brew install grep
brew install ack
brew install git
brew install git-lfs
brew install imagemagick --with-webp
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install rlwrap
brew install ssh-copy-id
brew install tree
brew install vbindiff
brew install yarn --without-node
brew install zopfli

# Devtools
brew install cmake
brew install gcc
brew install gdb
brew install go
brew install mongodb
brew install mysql
brew install node
brew install python@2
brew install python
# install python 3.6.5 (package like xgboost not compatible with 3.7 so far)
sudo mkdir /usr/local/Frameworks
sudo chown $(whoami):admin /usr/local/Frameworks
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/f2a764ef944b1080be64bd88dca9a1d80130c558/Formula/python.rb

# Install nano with syntax highlighting
brew install nano
wget https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh -O- | sh

# Install Python deps
pip3.6 install -r requirements.txt --upgrade --user

# Install Node modules
npm install -g cors
npm install -g body-parser
npm install -g express
npm install -g mongodb
npm install -g react
npm install -g create-react-app

# Install Docker
brew install docker docker-compose docker-machine xhyve docker-machine-driver-xhyve
sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve

# Remove outdated versions from the cellar.
brew cleanup

# Setup MacOs defaults
chmod +x .macos
./.macos

# Reboot
sudo reboot
