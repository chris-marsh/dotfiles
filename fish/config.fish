# Fish settings
set -gx  LC_ALL en_GB.UTF-8  
set -gx  LANG en_GB.UTF-8  
#set -gx fish_user_paths $fish_user_paths ~/bin /usr/lib/jvm/java-8-openjdk/bin
set -gx fish_user_paths $fish_user_paths ~/bin
set -gx EDITOR vim

if [ $TERM = "xterm" ]
    set -gx TERM xterm-256color
end

# Shell aliases
alias ls='ls --color=auto'
alias dir='ls -l'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias clr='clear'
alias c='clear'
alias df='df -h'  # Human readble numbers
alias cp='cp -i'  # Prompt on overwrite
alias mv='mv -i'  # Prompt on overwrite
alias vi='vim'
alias svim='sudo vim'

# ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias ll='ls -l'      #long list
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

#Startup apps
set fish_greeting ""
archey3
