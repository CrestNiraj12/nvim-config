return {
  {
    "preservim/tagbar",
    config = function()
      -- Keymaps
      vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', {noremap = true, silent = true})

      -- Options
      vim.g.tagbar_width = 30

      -- JavaScript configuration
      vim.g.tagbar_type_javascript = {
        ctagstype = 'javascript',
        kinds     = {
          'c:classes',
          'f:functions',
          'm:methods',
          'p:properties',
          'v:variables'
        },
      }

      -- Python configuration
      vim.g.tagbar_type_python = {
        ctagstype = 'python',
        kinds     = {
          'f:functions',
          'c:classes',
          'm:members',
          'v:variables',
          'i:imports'
        },
      }

      vim.g.tagbar_autofocus = 1
      vim.g.tagbar_sort = 0
    end,
  }
}
