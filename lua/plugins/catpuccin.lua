return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      local catpuccin = require("catppuccin")
      catpuccin.setup({})
      vim.opt.termguicolors = true
      vim.cmd.colorscheme("catppuccin")
    end
  },
}
