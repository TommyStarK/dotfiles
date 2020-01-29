export ZDOTDIR=$HOME/.zsh

ZSH_THEME="oxide/oxide"
COMPLETION_WAITING_DOTS="true"
plugins=(docker)

#
# Init
#

# add a function path
fpath=($ZSH/functions $fpath)

# Load the shell dotfiles
for file in ~/.{aliases,exports,functions,paths}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file

# Load all features files
for config_file ($ZDOTDIR/features/*.zsh) source $config_file

is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/plugins/$name/_$name
}

# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
  if is_plugin $ZDOTDIR $plugin; then
    fpath=($ZDOTDIR/plugins/$plugin $fpath)
  fi
done

# Load and run compinit
autoload -Uz compinit

# Load all of the plugins that were defined in the `plugins` variable in ~/.zshrc
for plugin ($plugins); do
  if [ -f $ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh
  fi
done

# Load theme if set
if [ ! "$ZSH_THEME" = ""  ]; then
	if [ -f "$ZDOTDIR/themes/$ZSH_THEME.zsh-theme" ]; then
		source "$ZDOTDIR/themes/$ZSH_THEME.zsh-theme"
	fi
fi

if test "`find ~/.zcompdump -mtime +1`"; then
	compinit -i -d ~/.zcompdump
else
	compinit -C
fi
