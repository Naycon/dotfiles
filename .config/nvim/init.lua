--------------------------------------------------
-- ENABLE TRUECOLORS
--------------------------------------------------
vim.o.termguicolors = true
--------------------------------------------------


--------------------------------------------------
-- REMAP LEADER
--------------------------------------------------
-- Set leader to "<space>"
vim.g.mapleader = " "
--------------------------------------------------


--------------------------------------------------
-- SHOW LINE NUMBERS
--------------------------------------------------
-- vim.o.number = true
--------------------------------------------------


--------------------------------------------------
-- SPLIT BEHAVIOUR
--------------------------------------------------
-- set splitbelow
-- set splitright
vim.o.splitbelow = true
vim.o.splitright = true
--------------------------------------------------


--------------------------------------------------
-- SET TABS TO 2 SPACES
--------------------------------------------------
-- On pressing tab, insert 2 spaces
vim.o.expandtab = true
-- show existing tab with 2 spaces width
vim.o.tabstop = 2
vim.o.softtabstop = 2
-- when indenting with '>', use 2 spaces width
vim.o.shiftwidth = 2
--------------------------------------------------


--------------------------------------------------
-- BACKUPCOPY BEHAVIOUR
--------------------------------------------------
-- Sets the backupcopy behaviour to avoid issues
-- with watchers (e.g. parcel) on Windows WSL.
vim.o.backupcopy = "yes"
--------------------------------------------------


--------------------------------------------------
-- HIGHLIGHT ON YANK
--------------------------------------------------
local highlight_yank = vim.api.nvim_create_augroup("highlight_yank", {})
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_yank,
  desc = 'Highlight on yank',
  callback = function(event)
    vim.highlight.on_yank({higroup = 'IncSearch', timeout = 200})
  end
})
--------------------------------------------------


--------------------------------------------------
-- TRIM WHITESPACE ON SAVE
--------------------------------------------------
-- Change * below if stripping is not desired on all file endings. E.g. set it
-- to {'*.js','*.ts'}  to only strip whitespace on js and ts files.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
--------------------------------------------------


--------------------------------------------------
-- FORMAT ON SAVE
--------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx", "*.mjs"},
  command = "FormatWrite",
})
--------------------------------------------------


--------------------------------------------------
-- CLIPBOARD CONFIG
--------------------------------------------------
vim.opt.clipboard = "unnamedplus"

if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
      ["+"] = "win32yank.exe -i --crlf",
      ["*"] = "win32yank.exe -i --crlf",
    },
    paste = {
      ["+"] = "win32yank.exe -o --lf",
      ["*"] = "win32yank.exe -o --lf",
    },
    cache_enabled = 0,
  }
end
--------------------------------------------------


--------------------------------------------------
-- SET HIDDEN
--------------------------------------------------
-- Needed to be able to change buffer without saving first.
vim.o.hidden = true
--------------------------------------------------


--------------------------------------------------
-- ENABLE WILDMENU <TAB> COMPLETION
--------------------------------------------------
vim.o.wildmode = "longest:full,full"
--------------------------------------------------


--------------------------------------------------
-- NATIVE NVIM KEYBINDINGS
--------------------------------------------------
-- (Plugin keybindings are defined in the plugins config function)
-- esc leaves insert mode in terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
-- gh switches between the last two buffers
vim.keymap.set('n', 'gh', ':b#<CR>')
-- arrow keys to move between splits
vim.keymap.set('n', '<Left>', '<c-w>h')
vim.keymap.set('n', '<Down>', '<c-w>j')
vim.keymap.set('n', '<Up>', '<c-w>k')
vim.keymap.set('n', '<Right>', '<c-w>l')
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { silent = true })
--------------------------------------------------


--------------------------------------------------
-- LAZY.NVIM
--------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
--------------------------------------------------


--------------------------------------------------
-- SET COLORSCHEME
--------------------------------------------------
vim.cmd('colorscheme bluloco')
--------------------------------------------------


--------------------------------------------------
-- SET END OF BUFFER FILL CHARACTER TO SPACE
--------------------------------------------------
vim.opt.fillchars='eob: '
--------------------------------------------------
