
return {
  -- Other plugin configurations...

  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- Ensure Treesitter is a dependency
    config = function()
      -- Enable nvim-ts-rainbow2 with default settings
      require('nvim-treesitter.configs').setup {
        rainbow = {
          enable = true,
          -- Extend to any language you wish to have rainbow parentheses
          -- Below are some sensible defaults
          languages = {
            "clojure", "lisp", "scheme",
            "javascript", "typescript", "css",
            "html", "svelte", "vue", "lua", "python",
          },
          -- Additional configuration options can be set here
        },
      }
    end
  },

  -- Further plugin configurations...
}
