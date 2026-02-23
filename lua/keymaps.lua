local set = vim.keymap.set

-- Splits
set('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true, desc = 'Horizontal Split' })
set('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Vertical Split' })

-- Switch between splits with Ctrl + h/j/k/l
set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })
set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })

-- Save file
set('n', '<leader>s', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })
-- Close file
set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Close file' })


local flutter_cmd = ":FlutterRun -t lib/main.dart"
-- Map F1 to run the 'free' flavor
set('n', '<F1>', flutter_cmd .. ' --flavor dev<CR>', { noremap = true })

-- Map F2 to run the 'paid' flavor
set('n', '<F5>', flutter_cmd .. ' --flavor prod<CR>', { noremap = true })

set('n', '<leader>d', ':FlutterDevices<CR>', { noremap = true })
set('n', '<leader>fe', ':FlutterEmulators<CR>', { noremap = true })
set('n', '<leader>m', ':FlutterRestart<CR>', { noremap = true })
set('n', '<leader>r', ':FlutterReload<CR>', { noremap = true })
set('n', '<leader>w', ':FlutterQuit<CR>', { noremap = true })
set('n', '<leader>lc', ':FlutterLogClear<CR>', { noremap = true })
set('n', '<leader>lt', ':FlutterLogToggle<CR>', { noremap = true })

set('n', '<leader>bg', ':Telescope git_bcommits<CR>', { noremap = true })

-- DAP repl toggle
set('n', '<leader>dr', ':DapToggleRepl<CR>', { noremap = true })
set('n', '<leader>dt', ':DapToggle<CR>', { noremap = true })

-- Horizontal Scroll
set('n', '<Right>', 'zL', { noremap = true, desc = 'Horizontal Scroll Left' })
set('n', '<Left>', 'zH', { noremap = true, desc = 'Horizontal Scroll Right' })

-- Resize split
set('n', '+', '<C-w>+', { noremap = true, desc = 'Increase split size' })
set('n', '_', '<C-w>-', { noremap = true, desc = 'Decrease split size' })
set('n', '-', '<C-w><', { noremap = true, desc = 'Increase split width' })
set('n', '=', '<C-w>>', { noremap = true, desc = 'Decrease split width' })

-- Oil
set('n', 'n', '<CMD>Oil<CR>', { desc = "Open parent directory" })
set("n", "<leader>xl", "<cmd>lua require('dap.repl').clear()<CR>", { noremap = true, silent = true })

set("n", "<leader>sw", function()
  require("spectre").open_visual({ select_word = true })
end, { desc = "Search current word" })

set("v", "<leader>sw", function()
  require("spectre").open_visual()
end, { desc = "Search selection" })

set("n", "<leader>sp", function()
  require("spectre").open_file_search({ select_word = true })
end, { desc = "Search in current file" })

set("n", "<leader>cL", function()
  local log = vim.fn.stdpath("state") .. "/lsp.log"
  vim.fn.writefile({}, log)
  print("LSP log cleared")
end, { desc = "Clear LSP log" })

set("n", "<leader>nn", ":noh<CR>", { desc = "Clear search highlights" })

-- Diffview
set("n", "<leader>Dg", "<cmd>DiffviewOpen<cr>", { desc = "Git Diff (Diffview)" })
set("n", "<leader>Dc", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })
set("n", "<leader>Dh", "<cmd>DiffviewFileHistory<cr>", { desc = "Git File History" })
set("n", "<leader>DH", "<cmd>DiffviewFileHistory %<cr>", { desc = "Current File History" })
