# --- Homebrew ---
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- プラグイン (Sheldon) ---
if [[ $(command -v sheldon) ]]; then
  eval "$(sheldon source)"

  # Tab補完エンジンを初期化（zsh-completions の定義もここで読み込まれる）
  autoload -Uz compinit && compinit

  # ↑↓ で入力文字列に絞り込みながら履歴を遡る
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# --- ツール初期化 ---
[[ $(command -v mise) ]] && eval "$(mise activate zsh)"        # 言語バージョン管理
[[ $(command -v starship) ]] && eval "$(starship init zsh)"   # プロンプト
[[ $(command -v zoxide) ]] && eval "$(zoxide init zsh)"       # cd の強化版（z コマンド）

# Ctrl+R で履歴検索。最新が上に表示され↓で古い方へ遡る
export FZF_CTRL_R_OPTS="--layout=reverse"
[[ $(command -v fzf) ]] && source <(fzf --zsh)

# --- Tab補完の設定 ---
zstyle ':completion:*' completer _complete
zstyle ':completion:*:descriptions' format '[%d]'  # 候補グループに見出しを表示
setopt menu_complete                                # 候補が1つでもfzf画面を出す
_comp_options+=(globdots)                           # .で始まる隠しファイルも補完に出す

# --- AWS CLI補完 ---
# aws_completer は候補名のみで説明文なし（仕様上の制限）
if [[ $(command -v aws_completer) ]]; then
  autoload -Uz bashcompinit && bashcompinit
  complete -C aws_completer aws
fi

# --- 履歴 ---
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt share_history        # 複数ウィンドウ間で履歴を共有
setopt hist_reduce_blanks   # 余分なスペースを削除して保存
setopt no_beep
setopt hist_ignore_all_dups # 重複コマンドは古い方を削除

# --- エイリアス ---
if [[ $(command -v eza) ]]; then
  alias ls='eza --icons --git'
  alias ll='eza -al --icons --git'
  alias tree='eza --tree --icons'
fi

[[ $(command -v bat) ]] && alias cat='bat'

alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"

# --- 関数 ---
# 必要であればここに追加
