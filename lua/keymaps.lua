local set = vim.keymap.set

-- Splits
set('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true, desc = 'Horizontal Split' })
set('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Vertical Split' })

-- Switch between splits with Ctrl + h/j/k/l
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Buffer Close All
set('n', '<leader>ba', ':bufdo bd<CR>', { noremap = true, silent = true, desc = 'Buffer Close All' })
-- Save file
set('n', '<leader>s', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })
-- Close file
set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Close file' })


local flutter_cmd = ":FlutterRun -t lib/main.dart"
-- Map F1 to run the 'free' flavor
set('n', '<F1>', flutter_cmd .. ' --flavor dev<CR>', { noremap = true })

-- Map F2 to run the 'paid' flavor
set('n', '<F5>',  flutter_cmd .. ' --flavor prod<CR>', { noremap = true })

set('n', '<leader>d', ':FlutterDevices<CR>', { noremap = true })
set('n', '<leader>fe', ':FlutterEmulators<CR>', { noremap = true })
set('n', '<leader>m', ':FlutterRestart<CR>', { noremap = true })
set('n', '<leader>r', ':FlutterReload<CR>', { noremap = true })
set('n', '<leader>w', ':FlutterQuit<CR>', { noremap = true })

-- Lazy Git Command
set('n', '<leader>lg', ':LazyGit<CR>', { noremap = true })


