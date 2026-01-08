return {
  dir = "~/projects/bundle-size.nvim",
  lazy = false,
  config = function()
    require("bundle_size").setup()
  end
}
