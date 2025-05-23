return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    {
      'MeanderingProgrammer/render-markdown.nvim',
      ft = { 'markdown', 'codecompanion' },
    },
  },
  config = function()
    local gemini_api_key = os.getenv("GEMINI_API_KEY")

    if gemini_api_key == nil then
      vim.notify("Gemini API key not found!", vim.log.levels.ERROR)
    else
      print("Gemini API key loaded successfully")
    end

    require('codecompanion').setup {
      strategies = {
        chat = {
          adapter = 'gemini',
        },
        inline = {
          adapter = 'gemini',
        },
      },
      adapters = {
        gemini = function()
          return require("codecompanion.adapters").extend("gemini", {
            env = {
              api_key = gemini_api_key,
            },
            schema = {
              model = {
                default = "gemini-2.0-flash",
              },
            },
          })
        end,
      },
    }
  end,
}
