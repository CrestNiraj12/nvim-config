return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  keys = {
    {
      "<leader>Dg",
      "<cmd>DiffviewOpen<cr>",
      desc = "Git Diff (Diffview)",
    },
    {
      "<leader>Dc",
      "<cmd>DiffviewClose<cr>",
      desc = "Close Diffview",
    },
    {
      "<leader>Dh",
      "<cmd>DiffviewFileHistory<cr>",
      desc = "Git File History",
    },
    {
      "<leader>DH",
      "<cmd>DiffviewFileHistory %<cr>",
      desc = "Current File History",
    }
  }
}
