return {
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            -- Key mapping configuration
            -- Replace <YourKeyBind> with your preferred keybind, e.g., '<leader>lg'
            vim.api.nvim_set_keymap('n', '<leader>lg', ':LazyGit<CR>', { noremap = true, silent = true })

            -- Optional: Configuration for lazygit.nvim appearance or behavior
            -- vim.g.lazygit_floating_window_use_plenary = 1 -- Use plenary.nvim for floating window (if needed)
            -- vim.g.lazygit_floating_window_winblend = 0 -- Transparency for floating window (0-100)
            -- vim.g.lazygit_floating_window_scaling_factor = 0.9 -- Scale the floating window size
            -- vim.g.lazygit_floating_window_corner_chars = { '╭', '╮', '╰', '╯' } -- Custom corner characters for the floating window
            -- vim.g.lazygit_floating_window_border = 'single' -- Border style: 'single', 'double', 'rounded', 'solid', or 'shadow'
        end
    },
    -- Add other plugins here
}
