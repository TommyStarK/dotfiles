[ -n "$PS1" ] && source ~/.bash_profile;
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

complete -C /usr/local/sbin/vault vault
