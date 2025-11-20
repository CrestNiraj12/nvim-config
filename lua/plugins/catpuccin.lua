return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    local editor_bg = "#15151c"   -- main editor
    local sidebar_bg = "#14141a"  -- Neo-tree
    local mantle_bg = "#1a1a23"
    local crust_bg  = "#101017"

    local catppuccin = require("catppuccin")

    catppuccin.setup({
      flavour = "mocha",
      background = { dark = "mocha", light = "latte" },
      transparent_background = false,
      term_colors = false,

      color_overrides = {
        mocha = {
          base   = editor_bg,
          mantle = mantle_bg,
          crust  = crust_bg,
        },
      },

      custom_highlights = function(colors)
        return {
          -- main editor
          Normal   = { fg = colors.text, bg = editor_bg },
          NormalNC = { fg = colors.text, bg = editor_bg },

          -- floats / popups
          NormalFloat = { fg = colors.text, bg = mantle_bg },
          FloatBorder = { fg = "#3b3b4a", bg = mantle_bg },

          -- cursorline & visual just so things look sane
          CursorLine = { bg = "#1c1c25" },
          Visual     = { bg = "#28304a" },

          -- Neo-tree sidebar (darker)
          NeoTreeNormal      = { fg = colors.text, bg = sidebar_bg },
          NeoTreeNormalNC    = { fg = colors.text, bg = sidebar_bg },
          NeoTreeWinSeparator = { fg = sidebar_bg, bg = sidebar_bg },
          NeoTreeIndentMarker = { fg = "#2e2e3a" },
          NeoTreeExpander = { fg = "#6b6b8a" }
        }
      end,

      integrations = {
        cmp = true,
        gitsigns = true,
        neotree = true,
        treesitter = true,
        telescope = true,
        dap = true,
        dap_ui = true,
      },
    })

    vim.cmd("colorscheme catppuccin")

    -- extra safety: force backgrounds in case something re-highlights later
    vim.api.nvim_set_hl(0, "Normal",   { bg = editor_bg })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = editor_bg })
  end,
}
