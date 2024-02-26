return {
  "numToStr/Comment.nvim",
  config = function()
    require('Comment').setup({
      -- Sensible options for Comment.nvim
      padding = true, -- Add a space between the comment symbol and the line content
      sticky = true, -- Whether the cursor should stay at the current line or not
      ignore = nil, -- Lines matching the pattern will not be commented
      toggler = {
        line = 'gcc', -- Toggle comment for the current line
        block = 'gbc', -- Toggle comment for the current block
      },
      opleader = {
        line = 'gc', -- Toggle comment for lines in operator pending mode
        block = 'gb', -- Toggle comment for blocks in operator pending mode
      },
      extra = {
        above = 'gcO', -- Add comment on the line above
        below = 'gco', -- Add comment on the line below
        eol = 'gcA', -- Add comment at the end of line
      },
      mappings = {
        -- Basic mapping, set to false to disable
        basic = true, -- Enable all basic mappings
        extra = true, -- Enable extra mappings
        extended = false, -- Disable extended mappings
      },
      -- Uncomment below if you want to set specific language options
      -- pre_hook = function(ctx)
      --   -- Example: return '//' for tsx files instead of the default
      --   if vim.bo.filetype == 'typescriptreact' then
      --     return '//'
      --   end
      -- end,
    })

    -- Optional: Set keymaps manually if you want to customize further
    --[[ local map = vim.api.nvim_set_keymap
    local opts = {noremap = true, silent = true}
    map('n', 'gcc', '<cmd>CommentToggle<CR>', opts)
    map('v', 'gc', '<cmd>CommentToggle<CR>', opts) ]]
  end,
  opts = {}
}
