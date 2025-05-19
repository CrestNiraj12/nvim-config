return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "VeryLazy",
  config = function()
    require("treesitter-context").setup({
      enable = true,        -- Enable this plugin
      max_lines = 3,        -- Show up to 3 lines for context
      trim_scope = 'outer', -- Remove outer context when limit is hit
      mode = 'cursor',      -- Show context at cursor (or 'topline')
      zindex = 20,          -- Stack order
    })
  end,
}
