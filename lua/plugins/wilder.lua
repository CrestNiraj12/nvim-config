return {
  {
    "gelguy/wilder.nvim",
    event = "VeryLazy", -- Load after startup, not on first use
    dependencies = { "romgrk/fzy-lua-native" }, -- Declare as a dependency
    config = function()
      local wilder = require('wilder')
      wilder.setup({
        modes = { ':', '/', '?' }, -- Enable wilder for command mode and search modes
      })

      -- Merge the configurations for renderer
      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_palette_theme({
          border = 'rounded',            -- 'single', 'double', 'rounded' or 'solid'
          max_height = '75%',            -- max height of the palette
          min_height = 0,                -- set to the same as 'max_height' for a fixed height window
          prompt_position = 'top',       -- 'top' or 'bottom' to set the location of the prompt
          reverse = 0,                   -- set to 1 to reverse the order of the list
          -- Incorporating highlighter configuration
          highlighter = {
            wilder.lua_pcre2_highlighter(),         -- requires `luarocks install pcre2`
            wilder.lua_fzy_highlighter(),           -- optional, requires fzy-lua-native vim plugin
          },
          highlights = {
            accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
          },
        })
      ))
      -- Ensure the dependencies for the highlighters are met:
      -- 1. `luarocks install pcre2` for lua_pcre2_highlighter
      -- 2. `fzy-lua-native` is now a dependency
    end
  },
}
