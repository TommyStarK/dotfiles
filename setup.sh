# #!/usr/bin/env bash

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
	ca-certificates \
	consul-template \
	coreutils \
	curl \
	ed \
	findutils \
	gawk \
	gcc \
	gdb \
	gh \
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
	helm \
	htop \
	jq \
	kind \
	kubernetes-cli \
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
	sonar-scanner \
	sqlite \
	ssh-copy-id \
	tcpdump \
	terraform \
	tig \
	tree \
	vault \
	vegeta \
	watch \
	wireshark \
	wget \
	yarn \
	yq \
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

# Switch to using brew-installed zsh as default shell
if ! fgrep -q '/usr/local/bin/zsh' /etc/shells; then
	echo '/usr/local/bin/zsh' | sudo tee -a /etc/shells;
	chsh -s /usr/local/bin/zsh;
fi;

for file in ./.{aliases,curlrc,editorconfig,exports,functions,gitconfig,paths,screenrc,wgetrc,zshrc}; do
	cp -v "$file" ~;
done;
unset file;

cp -R .zsh ~

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

pip3 install --upgrade pip
pip3 install -r requirements.txt

npm install -g ts-node

go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/perf/cmd/benchstat@latest
go install golang.org/x/tools/cmd/stress@latest

./.macos

sudo reboot
