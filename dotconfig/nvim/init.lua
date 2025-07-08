-- Basic vim settings
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Show relative line numbers
vim.opt.mouse = 'a'           -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.termguicolors = false -- Use terminal colors

-- Leader key
vim.g.mapleader = ' '

-- Disable syntax highlighting
vim.cmd([[
  syntax off
  set nohlsearch
  set background=dark
]])

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  print('Installing lazy.nvim...')
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require('lazy').setup({
  -- Multi-cursor support
  {
    'mg979/vim-visual-multi',
    branch = 'master',
  },
}, {})

-- Configure vim-visual-multi
vim.g.VM_theme = 'iceblue'
vim.g.VM_highlight_matches = 'underline'
vim.g.VM_maps = {
  ["Find Under"] = "<C-d>",
  ["Find Subword Under"] = "<C-d>",
  ["Select Cursor Down"] = "<S-Down>",
  ["Select Cursor Up"] = "<S-Up>",
  ["Add Cursor At Pos"] = "<C-q>"
}
-- Ensure cursors are visible during editing
vim.g.VM_persistent_cursors = 1
vim.g.VM_show_warnings = 0
vim.g.VM_silent_exit = 0
-- Enhanced visibility settings
vim.g.VM_Mono_hl = 'DiffText'
vim.g.VM_Extend_hl = 'DiffAdd'
vim.g.VM_Cursor_hl = 'Visual'
vim.g.VM_Insert_hl = 'DiffChange'
-- Ensure real-time updates at all cursor positions
vim.g.VM_live_editing = 1

-- Basic key mappings
vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = 'Save' })
vim.keymap.set('n', '<leader>q', '<cmd>quit<cr>', { desc = 'Quit' })
