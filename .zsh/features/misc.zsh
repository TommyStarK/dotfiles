# If a command is issued that can’t be executed as a normal command, and the command is the name of a directory, 
# perform the cd command to that directory. This option is only applicable if the option SHIN_STDIN is set, i.e. 
# if commands are being read from standard input. The option is designed for interactive use; 
# it is recommended that cd be used explicitly in scripts to avoid ambiguity.
# setopt auto_cd

# If set, parameter expansion, command substitution and arithmetic expansion are performed in prompts. 
# Substitutions within prompts do not affect the command status.
setopt prompt_subst

# Print job notifications in the long format by default.
setopt long_list_jobs

# recognize comments
setopt interactivecomments
