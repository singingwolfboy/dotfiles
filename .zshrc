fpath=(~/zsh $fpath)
autoload -U compinit promptinit colors
compinit
promptinit
colors
autoload -Uz vcs_info
vcs_info
setopt prompt_subst

# hub
if which hub &> /dev/null; then
    eval "$(hub alias -s zsh)"
    local COMPL=/opt/local/share/zsh/site-functions/hub.zsh_completion
    test -r $COMPL && source $COMPL
fi

# vim-style keybindings
bindkey -v
# vim: backspace=start
bindkey "^W" backward-kill-word    # vi-backward-kill-word
bindkey "^H" backward-delete-char  # vi-backward-delete-char
bindkey "^U" kill-line             # vi-kill-line
bindkey "^?" backward-delete-char  # vi-backward-delete-char

zstyle ':vcs_info:*' actionformats \
        '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
        '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git svn

function rprompt_ln() {
  # MUST be called with \$(rprompt_ln [...])
  # currently, this cannot handle color escapes (althought I don't know why)
  # but it can handle zsh escapes like %m
  local left
  local right
  local left_tpl
  local right_stripped
  local spacing

  # strip color escapes using perl
  right_stripped=$(echo "$*" | command perl -pe 's/\e\[\d\dm//g')
  right=$(print -P $right_stripped)
  # strip out everything starting from "$(rprompt_ln"
  left_tpl=${PROMPT%\$\(rprompt_ln*};
  left=$(print -P $left_tpl | command perl -pe 's/\e\[\d\dm//g');
  (( spacing = ${COLUMNS} - ${#left} - ${#right} ))
  # right-align with printf
  printf "%${spacing}s%s" " " "$*"
}

precmd () { vcs_info }
PROMPT="%{$fg[green]%}%n %{$fg[white]%}%~ %{$fg[blue]%}"'${vcs_info_msg_0_}'"%{$reset_color %}\$(rprompt_ln %m)
%# "

# http://pthree.org/2009/03/28/add-vim-editing-mode-to-your-zsh-prompt/
# http://zshwiki.org/home/examples/zlewidgets
function zle-line-init zle-keymap-select {
    local CMD_TEXT="%{$fg[yellow]%}COMMAND%{$reset_color%}"
    local INS_TEXT=""
    VIMODE="${${KEYMAP/vicmd/${CMD_TEXT}}/(main|viins)/${INS_TEXT}}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
RPROMPT='$VIMODE'

# rbenv

if which rbenv &> /dev/null; then
  export PATH="$HOME/.rbenv/shims:${PATH}"
  local COMPL=/opt/local/share/zsh/site-functions/rbenv.zsh_completion
  test -r $COMPL && source $COMPL
  function rbenv() {
    command="$1"
    if [ "$#" -gt 0 ]; then
      shift
    fi

    case "$command" in
    shell)
      eval `rbenv "sh-$command" "$@"`;;
    *)
      command rbenv "$command" "$@";;
    esac
  }
fi
