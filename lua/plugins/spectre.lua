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
    {
      "<leader>sW",
      function()
        require("spectre").open_visual({ select_word = true })
      end,
      desc = "Search current word"
    },
    {
      "<leader>sp",
      function()
        require("spectre").open_file_search({ select_word = true })
      end,
      desc = "Search in current file"
    },
  },
  opts = {
    preview = {
      enabled = true,
    },
  },
}
