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

set('n', '<leader>ba', function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(bufnr)
          and vim.bo[bufnr].buftype == ''
          and not vim.bo[bufnr].readonly then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end
  end,
  { noremap = true, silent = true, desc = 'Buffer Close All' })
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
set('n', '<leader>dr', ':DapToggle<CR>', { noremap = true })

-- Lazy Git Command
set('n', '<leader>lg', ':LazyGit<CR>', { noremap = true })

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

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
