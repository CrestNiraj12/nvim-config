return {
  "nvim-pack/nvim-spectre",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Spectre",
  keys = {
    {
      "<leader>sr",
      function()
        require("spectre").toggle()
      end,
      desc = "Toggle Spectre",
    },
  },
  opts = {
    -- You can add custom options here
  },
}
