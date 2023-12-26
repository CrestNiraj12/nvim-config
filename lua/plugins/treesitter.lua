return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "c", "lua", "javascript", "html",
        "go", "dart", "typescript", "python",
        "dart", "vimdoc", "vim",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
