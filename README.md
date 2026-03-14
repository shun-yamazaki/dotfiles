# dotfiles

```bash
git clone https://github.com/shun-yamazaki/dotfiles ~/.dotfiles
cd ~/.dotfiles
make all
source ~/.zshrc
```

| Command    | Alias / Key  | Description                               |
| :--------- | :----------- | :---------------------------------------- |
| **eza**    | `ls`, `ll`   | アイコン・Gitステータス付きのファイル一覧 |
| **bat**    | `cat`        | シンタックスハイライト付きのファイル閲覧  |
| **zoxide** | `z`          | ディレクトリ履歴に基づいた高速移動        |
| **fzf**    | `Ctrl + r`   | コマンド履歴のあいまい検索                |
| **Neovim** | `Ctrl + n`   | ファイルツリー (NvimTree) の開閉          |
| **Neovim** | `Space + ff` | プロジェクト内のファイル検索 (Telescope)  |

## セットアップ完了後の確認・設定リスト

### 1. iTerm2 の設定
- [ ] **Font**: `Settings` > `Profiles` > `Text` > `Font` で `JetBrainsMono Nerd Font` を選択。
- [ ] **Ligatures**: 同じ画面の `Use Ligatures` にチェックを入れる。
- [ ] **Terminal**: `Profiles` > `Terminal` > `Report terminal type` を `xterm-256color` に設定。

### 2. 1Password (SSH署名)
- [ ] **SSH Agent**: 1Passwordアプリの `Settings` > `Developer` > `Use the SSH agent` にチェックを入れる。
- [ ] **動作確認**: `git commit` を実行し、承認プロンプトが出るか確認。

### 3. エディタ (Cursor / VS Code)
- [ ] **Import**: 初回起動時に VS Code の設定をインポート。
- [ ] **Settings**: `settings.json` がリンクされているため、フォントやテーマが反映されているか確認。

### 4. AWS CLI
- [ ] **認証**: `aws configure` を実行し、Access Key ID / Secret Access Key を設定。
- [ ] **S3確認**: `s5cmd ls` でバケット一覧が表示されるか確認。

### 5. 言語ランタイム (mise)
- [ ] **Node.js**: `mise use --global node@latest`
- [ ] **PHP**: `mise use --global php@latest`
- [ ] **反映**: `source ~/.zshrc`

### 6. Claude Code
- [ ] **認証**: `claude` コマンドを実行し、ブラウザ経由でログイン。

### ServBay（手動インストール必要）
- [ ] https://www.servbay.com/download から .dmg をダウンロードしてインストール

---

### ツール動作確認
- [ ] `ll` : eza (アイコン付きリスト)
- [ ] `z <dir>` : zoxide (ディレクトリ移動)
- [ ] `vi` : nvim (エディタ)
- [ ] `cat <file>` : bat (ハイライト付き表示)
