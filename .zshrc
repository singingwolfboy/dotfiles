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

# http://net.tutsplus.com/tutorials/tools-and-tips/how-to-customize-your-command-prompt/
function put_spacing() {
  local hn=$(print -P %m)
  local dir=$(print -P %~)
  local vcs_cnt
  if [[ -n ${vcs_info_msg_0_} ]]; then
    (( vcs_cnt = ${#vcs_info_msg_0_} - 34 ))
  else
    vcs_cnt=0
  fi
  if [[ -n ${hn} ]]; then
    ((hn - ${#hn} - 10))
  else
    hn=0
  fi
  local numspaces
  (( numspaces = ${COLUMNS} - ${#USER} - ${#dir} - ${#hn} - ${vcs_cnt} - 3 ))
  # print -n $numspaces
  local spaces=""
  for i in {1..$numspaces}; do
    spaces="${spaces} "
  done
  echo -n $spaces
}

precmd () { vcs_info }
PROMPT="%{$fg[green]%}%n %{$fg[white]%}%~ %{$fg[blue]%}"'${vcs_info_msg_0_}'"%{$reset_color %}\$(put_spacing)%m
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
