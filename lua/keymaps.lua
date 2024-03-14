
local set = vim.keymap.set

-- Horizontal split
set('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true, desc = 'Horizontal Split' })

-- Vertical split
set('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Vertical Split' })

-- Switch between splits with Ctrl + h/j/k/l
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

-- Buffer Close
set('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true, desc = 'Buffer Close' })

-- Buffer List
set('n', '<leader>bl', ':ls<CR>', { noremap = true, silent = true, desc = 'Buffer List' })

-- Buffer Close All
set('n', '<leader>ba', ':bufdo bd<CR>', { noremap = true, silent = true, desc = 'Buffer Close All' })

-- Save file
set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })
set('n', '<C-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })
