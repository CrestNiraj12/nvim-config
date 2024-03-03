return {
  {
    'akinsho/toggleterm.nvim', 
    version = "*", 
    opts = {
      -- Terminal configuration options
      size = 20, -- Terminal size: can be a number or a function for dynamic sizing
      hide_numbers = true, -- Hide line numbers in toggleterm buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2, -- The degree by which to darken the terminal (1-3)
      start_in_insert = true,
      insert_mappings = true, -- Whether or not to map keys in insert mode
      persist_size = true,
      direction = 'float', -- Use a floating window for the terminal
      float_opts = {
        -- Floating window configuration options
        border = 'curved', -- Border style: 'single', 'double', 'shadow', 'curved'...
        width = 80, -- Width of the floating window
        height = 20, -- Height of the floating window
        winblend = 3,
      },
      -- Function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!") -- Automatically enter insert mode
      end,
      -- Function to run on closing the terminal
      on_close = function(term)
        vim.cmd("Closing terminal")
      end,
    },
  }
}
