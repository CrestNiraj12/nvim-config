return {
  "zbirenbaum/copilot.lua",
  event = "InsertEnter",
  opts = {
    suggestion = {
      auto_trigger = true,
      debounce = 100, -- reduce rapid firing edits
      keymap = {
        accept = "<C-l>",
        dismiss = "<C-]>",
      },
    },
    filetypes = {
      dart = true, -- make sure Copilot works in Dart
      markdown = false,
    },
  },
  config = function(_, opts)
    require("copilot").setup(opts)
  end,
}
