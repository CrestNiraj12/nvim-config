return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "▏",  -- SUPER thin line
    },
    exclude = {
      filetypes = { "dart" },   -- Exclude dart files from indent lines
    },
  },
}
