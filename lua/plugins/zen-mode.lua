return {
  "folke/zen-mode.nvim",
  config = function()
    -- Sensible keymap for toggling Zen Mode
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }

    -- Toggle Zen Mode with a keymap, for example: <leader>z
    map('n', '<leader>z', '<cmd>ZenMode<CR>', opts)

    -- Optional: Configure Zen Mode further if needed
    require("zen-mode").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the Zen Mode documentation for configuration options
    })
  end
}
