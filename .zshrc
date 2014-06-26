# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
KEYTIMEOUT=1
unsetopt beep
bindkey -v

# This stops the escape key from acting weirdly
noop () { }
zle -N noop
bindkey -M vicmd '\e' noop

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/david/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U promptinit
promptinit

autoload -U colors && colors

. /usr/share/zsh/site-contrib/powerline.zsh

export PATH="$HOME/bin:$PATH"

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -A key

key[Home]=${terminfo[khome]}

key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi

bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
# Ctrl-R searches backward in history
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward
# dd deletes the entire line and the goes into insert mode
function delete_then_insert(){
  zle kill-whole-line
  zle vi-insert
}
zle -N  delete_then_insert
bindkey -M vicmd dd delete_then_insert

#change direction keys in vim mode
bindkey -M vicmd 'h' backward-char
bindkey -M vicmd 's' forward-char
bindkey -M vicmd 't' up-line-or-history
bindkey -M vicmd 'n' down-line-or-history
function delete_char_then_insert(){
  zle vi-insert
  zle forward-char
  zle backward-delete-char
}
zle -N  delete_char_then_insert
bindkey -M vicmd 'l' delete_char_then_insert

# make pacman easier to use
alias pacup='sudo pacman -Syu'
# color ls output
alias ls='ls --color=auto'
eval $(dircolors -b)
# color grep output
alias grep='grep --color=auto'
# colors man pages
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
			man "$@"
}

# My alias-s
alias fcsh-wrap='fcsh-wrap -optimize=true -static-link-runtime-shared-libraries=true'
alias fcsh-wrap-dbg='fcsh-wrap -compiler.debug=true'
alias fplog='tail -f ~/.macromedia/Flash_Player/Logs/flashlog.txt'
alias fp='flashplayerdebugger *.swf 2> /dev/null'
