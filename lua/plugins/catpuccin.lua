return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      transparent_background = false,
      color_overrides = {
        mocha = {
          base = "#12121b",   -- default is #1e1e2e → this is darker but not black
          mantle = "#1a1a23", -- slightly lighter than base
          crust = "#101017",  -- darker edge
        },
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        telescope = true,
      }
    })
    vim.cmd.colorscheme("catppuccin")
  end
}
