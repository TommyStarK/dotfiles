#!/usr/bin/env bash

xcode-select --install
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

sudo -v

brew update

brew upgrade

brew install  ack \
	ansible \
	argocd \
	bash \
	bash-completion \
	bat \
	consul-template \
	coreutils \
	curl \
	ed \
	findutils \
	gawk \
	gcc \
	gdb \
	git \
	git-delta \
	git-extras \
	git-lfs \
	gnu-sed \
	gnu-tar \
	go \
	graphviz \
	grep \
	grpcurl \
	htop \
	jq \
	kind \
	kubectl \
	k6 \
	libpq \
	lua \
	make \
	minikube \
	moreutils \
	mysql \
	node \
	openssh \
	p7zip \
	protobuf \
	python \
	redis \
	rename \
	screen \
	ssh-copy-id \
	tcpdump \
	terraform \
	tig \
	tree \
	vegeta \
	watch \
	wireshark \
	wget \
	yarn \
	zopfli \
	zsh

brew install --cask cmake \
	docker \
	emacs \
	fly \
	google-chrome \
	iterm2 \
	nano \
	visual-studio-code

brew install chipmk/tap/docker-mac-net-connect

brew cleanup

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

mkdir ~/.nvm && wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash

ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion /usr/local/etc/bash_completion.d/docker
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion /usr/local/etc/bash_completion.d/docker-machine
ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion /usr/local/etc/bash_completion.d/docker-compose

pip3 install --upgrade pip
pip3 install -r requirements.txt

npm install -g ts-node

go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/perf/cmd/benchstat@latest
go install golang.org/x/tools/cmd/stress@latest

./.macos

sudo reboot
