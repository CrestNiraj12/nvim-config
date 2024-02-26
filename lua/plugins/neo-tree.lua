return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { '<C-n>', "<cmd>Neotree toggle position=left <CR>", desc="Toggle Neo-tree" },
    -- Additional keymaps
    { '<leader>nf', "<cmd>Neotree toggle position=float <CR>", desc="Toggle Neo-tree in floating window" },
    { '<leader>nd', "<cmd>Neotree toggle position=left reveal_force_cwd=true <CR>", desc="Toggle Neo-tree and reveal current file" },
    { '<leader>nb', "<cmd>Neotree toggle position=left source=buffers <CR>", desc="Toggle Neo-tree with buffer list" },
    -- You can add more mappings as needed
  },
  config = function()
    local neotree = require("neo-tree")
    neotree.setup({
      filesystem = {
        filtered_items = {
          visible = true, -- hide just means dimmed
          hide_dotfiles = false,
          hide_gitignored = true,
        }
      }
    })
  end
}
