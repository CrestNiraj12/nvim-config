return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    exclude = {
      filetypes = { "dart" },   -- Exclude dart files from indent lines
    },
  },
}
