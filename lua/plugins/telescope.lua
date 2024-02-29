return {
  'nvim-telescope/telescope.nvim', tag = '0.1.5',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    {
      "nvim-telescope/telescope-ui-select.nvim",
      opts = {},
    }
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      },
      defaults = {
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
          }
        }
      }
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    local builtin = require("telescope.builtin")
    local k = vim.keymap
    -- Update these lines to include file_ignore_patterns in the options
    k.set("n", "<leader>ff", function() builtin.find_files({ file_ignore_patterns = {"migrations/.*"} }) end, {})
    k.set("n", "<leader>fg", function() builtin.live_grep({ file_ignore_patterns = {"migrations/.*"} }) end, {})
    k.set("n", "<leader>fb", builtin.buffers, {})
    k.set("n", "<leader>fh", builtin.help_tags, {})
  end
}
