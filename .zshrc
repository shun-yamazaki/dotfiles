# --- Homebrew Setup ---
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Plugin Manager (Sheldon) ---
# zsh-autosuggestions, syntax-highlighting 等を爆速で読み込み
if [[ $(command -v sheldon) ]]; then
  eval "$(sheldon source)"

  # 補完機能の有効化
  autoload -Uz compinit && compinit
fi

# --- Tool Initializations ---
[[ $(command -v mise) ]] && eval "$(mise activate zsh)"
# 補完や見た目の設定
[[ $(command -v starship) ]] && eval "$(starship init zsh)"
# スマートな cd
[[ $(command -v zoxide) ]] && eval "$(zoxide init zsh)"
# 履歴検索
[[ $(command -v fzf) ]] && source <(fzf --zsh)
# --- AWS CLI Completion ---
[[ $(command -v aws) ]] && source /opt/homebrew/bin/aws_zsh_completer.sh

# --- Zsh Options ---
# --- History Settings ---
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history           # インスタンス間で履歴を共有
setopt hist_reduce_blanks      # 余分なスペースを削除して記録
setopt no_beep
setopt hist_ignore_all_dups # 履歴の重複を無視

# --- Aliases (Modern Tools) ---
if [[ $(command -v eza) ]]; then
  alias ls='eza --icons --git'
  alias ll='eza -al --icons --git'
  alias tree='eza --tree --icons'
fi

if [[ $(command -v bat) ]]; then
  alias cat='bat'
fi

# --- Aliases (Safety & Neovim) ---
alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# --- Functions ---
# 必要であればここに独自の関数を追加
