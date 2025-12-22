return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
    },
    event = "BufReadPost",
    config = function()
      vim.o.foldcolumn = "1" -- show fold column
      vim.o.foldlevel = 99   -- open everything by default
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local set = vim.keymap.set

      set("n", "zR", require("ufo").openAllFolds)
      set("n", "zM", require("ufo").closeAllFolds)

      set("n", "zr", require("ufo").openFoldsExceptKinds)
      set("n", "zm", require("ufo").closeFoldsWith)

      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- Use treesitter + indent (best combo)
          return { "treesitter", "indent" }
        end,
      })
    end,
  },
}
