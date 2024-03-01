return {
        "wellle/context.vim",
        cmd = {"ContextToggle"}, -- Lazy-load when the ContextToggle command is used
        config = function()
            -- Sensible Key Mapping for toggling context.vim
            vim.api.nvim_set_keymap('n', '<leader>ct', ':ContextToggle<CR>', {noremap = true, silent = true})

            -- Optional: Configure context.vim settings
            -- For example, to automatically turn on context when opening files:
            -- vim.g.context_enabled = 1

            -- To limit the context display to certain file types:
            -- vim.g.context_filetype_blacklist = {'nerdtree', 'fzf'}
        end,
    }
