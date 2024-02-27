return {
  {
    'tpope/vim-fugitive',
    event = "VeryLazy",  -- Adjust the event for your specific needs or preferences
    config = function()
      -- Keymaps for common Git operations
      -- Use the leader key as a prefix for all fugitive commands to avoid collisions
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Git status
      map('n', '<leader>gs', ':Git status<CR>', opts)

      -- Git blame
      map('n', '<leader>gb', ':Git blame<CR>', opts)
      -- Additional commands can be mapped based on your workflow needs
    end
  },
}
