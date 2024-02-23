return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require('trouble').setup()
    vim.keymap.set("n", "<leader>tro", "<cmd>TroubleToggle<CR>")
    vim.keymap.set("n", "<leader>trw", "<cmd>Trouble lsp_workspace_diagnostics<CR>")
    vim.keymap.set("n", "<leader>trq", "<cmd>Trouble quickfix<CR>")
  end
}
