return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    -- Require the harpoon module
    local harpoon = require('harpoon')
    harpoon.setup({
      -- Example configuration:
      menu = {
        width = 60, -- Adjust menu width if needed
      },
    })

    -- Basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    -- Keymap to open the list of harpooned files with Telescope
    vim.keymap.set("n", "<leader>ht", function() toggle_telescope(harpoon:list()) end,
      { desc = "Open Harpoon List with Telescope" })

    -- Additional Harpoon Keymaps
    -- Mark the current file or toggle mark
    vim.keymap.set('n', '<leader>hm', function() harpoon:list():add() end, { desc = "Harpoon: Mark/Unmark File" })

    -- Open the Harpoon menu directly
    vim.keymap.set('n', '<leader>ha', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
      { desc = "Harpoon: Toggle Menu" })

    -- Navigate to the next and previous marks
    vim.keymap.set('n', '<leader>hn', function() harpoon:list():next({ ui_nav_wrap = true }) end,
      { desc = "Harpoon: Next Mark" })
    vim.keymap.set('n', '<leader>hp', function() harpoon:list():prev({ ui_nav_wrap = true }) end,
      { desc = "Harpoon: Previous Mark" })
  end
}
