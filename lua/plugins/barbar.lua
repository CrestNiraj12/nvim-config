
return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  init = function()
    vim.g.barbar_auto_setup = false
    -- Define key mappings here. Example:
    local map = vim.api.nvim_set_keymap
    local opts = { noremap = true, silent = true }
    map('n', '<Tab>', ':BufferNext<CR>', opts)
    map('n', '<S-Tab>', ':BufferPrevious<CR>', opts)
    map('n', '<leader>bc', ':BufferClose<CR>', opts)
    -- Add more mappings as needed
  end,
  opts = {
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' }
    }
  },
  version = '^1.0.0',
}
