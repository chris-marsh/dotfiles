# Shell functions

# Extract from archive file
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

# Find process
psgrep() {
    if [ ! -z $1 ] ; then
        echo "Grepping for processes matching $1..."
        ps aux | grep $1 | grep -v grep
    else
        echo "!! Need name to grep for"
    fi
}

if [ "$TERM" = "linux" ]; then
  /bin/echo -e "
  \e]P023131a
  \e]P12e1b23
  \e]P2452935
  \e]P3633e4e
  \e]P48a586d
  \e]P5b57892
  \e]P6cdaab8
  \e]P7ebdfe4
  \e]P8f4d7c4
  \e]P9f9dac4
  \e]PA9bbc50
  \e]PBe6b7c9
  \e]PCeab5ca
  \e]PDbbd689
  \e]PEc7a5ed
  \e]PFded2ee
  "
  # get rid of artifacts
  clear
fi

