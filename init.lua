-- ==========================================
-- 1. 基本設定 (Options)
-- ==========================================
vim.g.mapleader = " " -- リーダーキーをSpaceに
local opt = vim.opt

opt.number = true         -- 行番号表示
opt.mouse = "a"           -- マウス有効
opt.clipboard = "unnamedplus" -- クリップボード共有
opt.tabstop = 4           -- タブ幅
opt.shiftwidth = 4
opt.expandtab = true      -- スペース使用
opt.ignorecase = true     -- 検索時大文字小文字無視
opt.smartcase = true
opt.cursorline = true     -- カーソル行を強調
opt.termguicolors = true  -- 真の色表示

-- ==========================================
-- 2. プラグイン管理 (lazy.nvim)
-- ==========================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- カラースキーム (目に優しいモダンな黒)
  { "rebelot/kanagawa.nvim", config = function() vim.cmd("colorscheme kanagawa") end },

  -- ファイルツリー (NERDTreeの代わり)
  { "nvim-tree/nvim-tree.lua", dependencies = "nvim-tree/nvim-web-devicons", config = true },

  -- ステータスライン (下部をおしゃれに)
  { "nvim-lualine/lualine.nvim", dependencies = "nvim-tree/nvim-web-devicons", config = true },

  -- あいまい検索 (fzfより強力な標準ツール)
  { "nvim-telescope/telescope.nvim", dependencies = "nvim-lua/plenary.nvim", config = true },

  -- シンタックスハイライト (コードを爆速で綺麗に色付け)
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", config = function()
      require("nvim-treesitter.configs").setup({ ensure_installed = { "lua", "javascript", "php", "json" }, highlight = { enable = true } })
    end },

  -- Git状態表示 (GitGutterの代わり)
  { "lewis6991/gitsigns.nvim", config = true },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "intelephense", "vtsls" } -- Lua, PHP, JS のLSP
      })
      require("mason-lspconfig").setup_handlers {
        function (server_name)
          require("lspconfig")[server_name].setup {}
        end,
      }
    end
  },
})

-- ==========================================
-- 3. キーマップ (直感的な操作)
-- ==========================================
local keymap = vim.keymap.set

-- ファイルツリー開閉 (Ctrl + n)
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { silent = true })

-- Telescope (ファイル検索: Space + ff, 履歴: Space + fr)
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, {})
keymap('n', '<leader>fg', builtin.live_grep, {})
keymap('n', '<leader>fr', builtin.oldfiles, {})

-- ハイライト消去 (Esc 2回)
keymap("n", "<Esc><Esc>", ":nohlsearch<CR>", { silent = true })
