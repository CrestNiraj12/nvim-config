return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    config = function()
      -- Set the variant (night or storm)
      vim.g.tokyonight_style = "storm" -- Options: "storm" or "night"
      
      -- Load the theme
      vim.cmd[[colorscheme tokyonight]]
    end
  },
}
