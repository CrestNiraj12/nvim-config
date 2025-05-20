return {
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        stages = "static",             -- Defines the animation of the notification
        background_colour = "#2E3440", -- Set the background color
        timeout = 3000,                -- Time (in milliseconds) before the notification disappears
        -- Custom icons for different notification levels
        icons = {
          ERROR = "",
          WARN = "",
          INFO = "",
          DEBUG = "",
          TRACE = "✎",
        },
        on_open = function(win)
          vim.api.nvim_win_set_option(win, "winblend", 0) -- no transparency
        end,
      })
      -- Map notification history view to <leader>nh in normal mode
      vim.keymap.set('n', '<leader>nh', require('notify').history, { desc = 'Notification History' })
    end
  }
}
