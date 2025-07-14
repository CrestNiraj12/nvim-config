return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<C-l>",         -- Accept suggestion
          next = "<C-j>",           -- Next suggestion
          prev = "<C-k>",           -- Previous suggestion
          dismiss = "<C-]>",
        },
      },
      panel = { enabled = false },  -- Optional, you can turn on the panel
    })
  end,
}
