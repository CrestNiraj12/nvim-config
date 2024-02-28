
local set = vim.keymap.set

-- Horizontal split
set('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true, desc = 'Horizontal Split' })

-- Vertical split
set('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Vertical Split' })

-- Buffer Close
set('n', '<leader>bd', ':bd<CR>', { noremap = true, silent = true, desc = 'Buffer Close' })

-- Buffer Next
set('n', '<leader>bn', ':bn<CR>', { noremap = true, silent = true, desc = 'Buffer Next' })

-- Buffer Previous
set('n', '<leader>bp', ':bp<CR>', { noremap = true, silent = true, desc = 'Buffer Previous' })

-- Buffer List
set('n', '<leader>bl', ':ls<CR>', { noremap = true, silent = true, desc = 'Buffer List' })

-- Buffer Close All
set('n', '<leader>ba', ':bufdo bd<CR>', { noremap = true, silent = true, desc = 'Buffer Close All' })
