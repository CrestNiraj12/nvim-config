return {
  'linux-cultist/venv-selector.nvim',
  dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
  branch = "regexp",
  config = function()
    require('venv-selector').setup {
      -- Your options go here
      -- name = "venv",
      -- auto_refresh = false
      name = {
        ".venv",
      }
    }
  end,
  event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    -- Keymap to open VenvSelector to pick a venv.
    { '<leader>ve', '<cmd>VenvSelect<cr>' },
  },
}
