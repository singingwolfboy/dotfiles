if [ -x /opt/local/bin/port ]; then
    export PREFIX="/opt/local"
else
    export PREFIX="/usr"
fi

export PATH="$HOME/local/bin:/usr/local/bin:$PREFIX/bin:$PREFIX/sbin:$PATH"
export EDITOR=`which vim`
export PAGER=`which less`

if [ -d /opt/local/lib/postgresql92 ]; then
    export PATH="$PATH:/opt/local/lib/postgresql92/bin"
fi

alias ls='ls -G'
alias less="less -R"
alias vless="$PREFIX/share/vim/vim73/macros/less.sh"

# color man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
