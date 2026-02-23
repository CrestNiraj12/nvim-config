return {
  "gelguy/wilder.nvim",
  event = "CmdlineEnter", -- Lazy-load on entering the command line
  dependencies = {
    "romgrk/fzy-lua-native"
  },
  config = function()
    local wilder = require('wilder')
    wilder.setup({
      modes = { ':', '/', '?' }, -- Enable wilder for command mode and search modes
    })

    -- Merge the configurations for renderer
    wilder.set_option('renderer', wilder.popupmenu_renderer(
      wilder.popupmenu_border_theme({
        min_width = '100%', -- minimum height of the popupmenu, can also be a number
        reverse = 0,        -- if 1, shows the candidates from bottom to top
        pumblend = 20,
        highlighter = wilder.lua_fzy_highlighter(),
        highlights = {
          accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
        },
        left = { " ", wilder.popupmenu_devicons() },
        right = { " ", wilder.popupmenu_scrollbar() },
      })
    ))

    -- Ensure the dependencies for the highlighters are met:
    -- 1. `luarocks install pcre2` for lua_pcre2_highlighter
    -- 2. Install `romgrk/fzy-lua-native` plugin for lua_fzy_highlighter
  end
}
