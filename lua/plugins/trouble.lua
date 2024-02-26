return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  init = function()
    -- Key mappings for trouble.nvim
    local map = vim.api.nvim_set_keymap
    local opts = {noremap = true, silent = true}

    -- Open Trouble with all diagnostics
    map("n", "<leader>xx", "<cmd>Trouble<cr>", opts)

    -- Open Trouble with diagnostics for the current buffer
    map("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>", opts)

    -- Open Trouble with document diagnostics
    map("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>", opts)

    -- Open Trouble with quickfix
    map("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", opts)

    -- Open Trouble with loclist
    map("n", "<leader>xl", "<cmd>Trouble loclist<cr>", opts)

    -- Close Trouble
    map("n", "<leader>xk", "<cmd>TroubleClose<cr>", opts)

    -- Use `g` to navigate items in Trouble (example bindings)
    -- Note: These mappings are optional and can be customized
    map("n", "g[", "<cmd>Trouble previous<cr>", opts)
    map("n", "g]", "<cmd>Trouble next<cr>", opts)
  end,
}
