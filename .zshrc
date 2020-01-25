export ZSH=$HOME/.zsh

ZSH_THEME="oxide/oxide"
COMPLETION_WAITING_DOTS="true"
plugins=(docker)

#
# Init
#

# Load the shell dotfiles
for file in ~/.{aliases,exports,functions,paths}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# add a function path
fpath=($ZSH/functions $ZSH/completions $fpath)

# Load all stock functions (from $fpath files) called below.
autoload -U compaudit compinit

# Load all features files
for config_file ($ZSH/features/*.zsh); do
	source $config_file
done

is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/plugins/$name/_$name
}

# Add all defined plugins to fpath. This must be done
# before running compinit.
for plugin ($plugins); do
  if is_plugin $ZSH $plugin; then
    fpath=($ZSH/plugins/$plugin $fpath)
  fi
done

# Figure out the SHORT hostname
if [[ "$OSTYPE" = darwin* ]]; then
  # macOS's $HOST changes with dhcp, etc. Use ComputerName if possible.
  SHORT_HOST=$(scutil --get ComputerName 2>/dev/null) || SHORT_HOST=${HOST/.*/}
else
  SHORT_HOST=${HOST/.*/}
fi

# Save the location of the current completion dump file.
if [ -z "$ZSH_COMPDUMP" ]; then
  ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
fi

if [[ $ZSH_DISABLE_COMPFIX != true ]]; then
  # If completion insecurities exist, warn the user
  if ! compaudit &>/dev/null; then
    handle_completion_insecurities
  fi
  # Load only from secure directories
  compinit -i -d "${ZSH_COMPDUMP}"
else
  # If the user wants it, load from all found directories
  compinit -u -d "${ZSH_COMPDUMP}"
fi

# Load all of the plugins that were defined in the `plugins` variable in ~/.zshrc
for plugin ($plugins); do
  if [ -f $ZSH/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZSH/plugins/$plugin/$plugin.plugin.zsh
  fi
done

# Load theme if set
if [ ! "$ZSH_THEME" = ""  ]; then
	if [ -f "$ZSH/themes/$ZSH_THEME.zsh-theme" ]; then
		source "$ZSH/themes/$ZSH_THEME.zsh-theme"
	fi
fi
