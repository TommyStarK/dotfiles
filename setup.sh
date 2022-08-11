#!/usr/bin/env bash

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
# Install latest Bash using Brew
brew install bash

# Switch to using brew-installed bash as default shell
if ! fgrep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

# Copy .files to HOME
for file in ./.{aliases,bash_profile,bash_prompt,bashrc,curlrc,editorconfig,exports,functions,gitconfig,inputrc,paths,screenrc,wgetrc}; do
	cp -v "$file" ~;
done;
unset file;

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
brew install grpcurl
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

cat << EOF >> ~/.nanorc

set tabsize 2
set tabstospaces
set indicator
set mouse
set zap
set afterends
set wordchars "_"
set historylog
set multibuffer

unbind ^K main
unbind ^U main
unbind ^W main
unbind ^G main

bind ^q exit all
bind ^h help main
bind ^x cut main
bind ^v paste main
bind ^z undo main
bind ^u redo main
bind ^f whereis main
bind ^r replace main
bind ^/ comment main
bind ^d gotoline main
bind ^G findnext main
bind ^b findbracket main
bind ^k cutfromcursor main
EOF

# Install nvm
mkdir ~/.nvm && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

# bash completion
# docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

# Install Python deps
pip3 install --upgrade pip
pip3 install -r requirements.txt

# Install Node modules
npm install -g ts-node

# Setup MacOs defaults
./.macos

# Reboot
sudo reboot
