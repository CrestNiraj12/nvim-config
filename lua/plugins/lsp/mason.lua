return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim" },
    },
  },
}

