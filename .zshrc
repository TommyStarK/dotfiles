# zmodload zsh/zprof
export ZDOTDIR=$HOME/.zsh
export ZSH=/usr/share/zsh/`zsh --version | grep -E "(\d\.){1,2}\d\s" |cut -d ' ' -f 2`

ZSH_THEME="oxide/oxide"
COMPLETION_WAITING_DOTS="true"
plugins=(docker)

fpath=($ZSH/functions $ZSH/help $fpath)

for file in ~/.{aliases,exports,functions,paths}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file

for config_file ($ZDOTDIR/features/*.zsh) source $config_file

is_plugin() {
  local base_dir=$1
  local name=$2
  test -f $base_dir/plugins/$name/$name.plugin.zsh \
    || test -f $base_dir/plugins/$name/_$name
}

for plugin ($plugins); do
  if is_plugin $ZDOTDIR $plugin; then
    fpath=($ZDOTDIR/plugins/$plugin $fpath)
  fi
done

autoload -Uz compinit

for plugin ($plugins); do
  if [ -f $ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh ]; then
    source $ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh
  fi
done

if [ ! "$ZSH_THEME" = ""  ]; then
  if [ -f "$ZDOTDIR/themes/$ZSH_THEME.zsh-theme" ]; then
    source "$ZDOTDIR/themes/$ZSH_THEME.zsh-theme"
  fi
fi

if [ ! -f ~/.zcompdump ]; then
  zcompile ~/.zcompdump
  compinit -i -d ~/.zcompdump
elif test "`find ~/.zcompdump -mtime +1`"; then
  compinit -i -d ~/.zcompdump
else
  compinit -C
fi

# zprof
