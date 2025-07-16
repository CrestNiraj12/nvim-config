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
          base = "#12121b",
          mantle = "#1a1a23",
          crust = "#101017",
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
