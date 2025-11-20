return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      color_overrides = {
        mocha = {
          base = "#16161e",
          mantle = "#1a1a23",
          crust = "#101017",
        },
      },
      custom_highlights = function(_)
        return {
          NeoTreeNormal       = { bg = "#13131c" },
          NeoTreeNormalNC     = { bg = "#13131c" },
          NeoTreeWinSeparator = { fg = "#13131c", bg = "#13131c" },
        }
      end,
      integrations = {
        dap_ui = true,
        dap = true,
        cmp = true,
        gitsigns = true,
        neotree = true,
        treesitter = true,
        telescope = true,
      }
    })
    vim.cmd.colorscheme("catppuccin")
  end
}
