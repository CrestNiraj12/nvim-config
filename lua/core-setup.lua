local opt = vim.opt

-- leader key --
vim.g.mapleader = " "

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- options --
opt.expandtab = false -- Changed from true to false for noexpandtab
opt.shiftwidth = 2
opt.tabstop = 2 
opt.smartindent = true -- Inherits autoindent behavior; smartindent implies autoindent

opt.colorcolumn = "120"
opt.fillchars = { eob = " " }
opt.mouse = "a"
opt.number = true
opt.relativenumber = true

-- use clipboard register --
opt.clipboard = "unnamedplus"

-- highlight line
opt.cursorline = true

-- exrc
opt.exrc = true

-- improved search
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- ...unless there is a capital letter in the query

-- undo history
opt.undofile = true -- Save undo history to disk, allowing undo after closing and reopening files

-- split window management
opt.splitright = true -- Vertical splits will open to the right
opt.splitbelow = true -- Horizontal splits will open below

-- wrap lines
-- :set wrap!
opt.wrap = false
