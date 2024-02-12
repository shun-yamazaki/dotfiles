# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

eval "$(anyenv init -)"

## ctrl + r で過去に実行したコマンドを選択できるようにする。
function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# setopt
setopt no_beep

# alias
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"

alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
