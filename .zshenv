if [ -x /opt/local/bin/port ]; then
    export PREFIX="/opt/local"
elif [ -x /usr/local/bin/brew ]; then
    export PREFIX="/usr/local"
else
    export PREFIX="/usr"
fi

export PATH="$HOME/local/bin:$PREFIX/bin:$PREFIX/sbin:$PATH"
export EDITOR=`which vim`
export PAGER=`which less`
export GOPATH=~/gopath

if [ -d /usr/local/share/python ]; then
    export PATH="/usr/local/share/python:$PATH"
fi
if [ -d /usr/local/share/npm ]; then
    export PATH="/usr/local/share/npm/bin:$PATH"
fi
if [ -d /opt/local/lib/postgresql92 ]; then
    export PATH="$PATH:/opt/local/lib/postgresql92/bin"
fi
if [ -x /usr/local/bin/brew ]; then
    local gettext_versions;
    gettext_versions=$(/usr/local/bin/brew list --versions gettext)
    if [ gettext_versions ]; then
        local gettext_array gettext_version;
        gettext_array=("${(s/ /)gettext_versions}")
        gettext_version=$gettext_array[-1]
        export PATH="$PATH:/usr/local/Cellar/gettext/$gettext_version/bin"
        export MANPATH="$MANPATH:/usr/local/Cellar/gettext/$gettext_version/share/man"
    fi
fi

alias ls='ls -G'
alias vless="$PREFIX/share/vim/vim73/macros/less.sh"

export LESS='-R'
# color man pages
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

alias gti=git
# `gi tpull` => `git pull`
gi() { x="${1:1}"; shift; git $x $*; }

export RBENV_ROOT=/usr/local/opt/rbenv

