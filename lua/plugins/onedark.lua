return {
    {
        'navarasu/onedark.nvim',  -- Add onedark theme
        config = function()
            require('onedark').setup {
                -- Your customization goes here. For example:
                style = 'cool', -- or 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'
                transparent = true, -- Enable this to make the background transparent
                term_colors = true,
                ending_tildes = false, -- Show ~ characters after the end of buffers
                -- More customization options and their details can be found in the onedark.nvim repo
            }
            require('onedark').load()  -- Don't forget to load the theme
        end
    },
    -- Add other plugins here
}
