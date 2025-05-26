return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        modules = {},
        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        ignore_install = {},
        ensure_installed = {
          "c", "lua", "javascript", "html",
          "go", "typescript", "python",
          "vimdoc", "vim", 'markdown', 'markdown_inline'
        },
        highlight = {
          enable = true,
          disable = { "dart" },
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
          disable = { "dart" }
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["at"] = "@tag.outer",
              ["it"] = "@tag.inner",
            },
          },
        },
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  -- Add your method/plugin for listing class methods, interfaces, etc., here
  -- Example: integration with Telescope or similar tool
}
