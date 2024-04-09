return {
  "ellisonleao/dotenv.nvim",
  lazy = false,
  config = function()
    require('dotenv').setup({
      enable_on_load = true,
    })
  end
}
