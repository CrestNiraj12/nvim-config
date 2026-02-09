return {
  "gelguy/wilder.nvim",
  event = "CmdlineEnter",
  build = ":UpdateRemotePlugins",
  dependencies = { "romgrk/fzy-lua-native" }, -- Declare as a dependency
  config = function()
    local wilder = require("wilder")

    wilder.setup({ modes = { ":", "/", "?" } })

    -- Use fuzzy matching for commands + file paths + searches
    wilder.set_option("pipeline", {
      wilder.branch(
        wilder.cmdline_pipeline({
          fuzzy = 1,
          fuzzy_filter = wilder.lua_fzy_filter(),
        }),
        wilder.vim_search_pipeline()
      ),
    })

    -- Popup menu renderer
    wilder.set_option(
      "renderer",
      wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
        border = "rounded",
        highlighter = wilder.lua_fzy_highlighter(),
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      }))
    )

    -- Keymaps for the wild menu
    wilder.set_option("next_key", "<Tab>")
    wilder.set_option("previous_key", "<S-Tab>")
    wilder.set_option("accept_key", "<CR>")
    wilder.set_option("reject_key", "<Esc>")
  end,
}
