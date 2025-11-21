return {
  require('plugins.lsp.mason'),
  require('plugins.lsp.lazydev'),
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'saghen/blink.cmp' },
      require('plugins.lsp.mason'),
      { 'Hoffs/omnisharp-extended-lsp.nvim' }
    },
    config = function()
      require('plugins.lsp.config').setup()
      require('plugins.lsp.flutter').setup()
      require('plugins.lsp.keymaps').setup()
    end
  }
}
