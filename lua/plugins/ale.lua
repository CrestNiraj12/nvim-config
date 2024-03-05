return {
        "dense-analysis/ale",
        event = "BufRead", -- Adjust the event for when you want ALE to load
        config = function()
            -- ALE basic configuration
            vim.g.ale_lint_on_enter = 1 -- Lint files when they are opened
            vim.g.ale_lint_on_save = 1  -- Lint files when they are saved
            vim.g.ale_lint_on_text_changed = 'always'  -- Lint files as you type

            -- Additional ALE settings...
            -- Set up any ALE linters, fixers, or other options as needed
            -- Example: Enable specific linters
            vim.g.ale_linters = {
                python = {'flake8', 'mypy', 'ruff', 'refurb', 'bandit', 'vulture', 'cspell'},
                -- Add other languages and linters as needed
            }

            -- Example: Enable ALE fixers
            vim.g.ale_fixers = {
                python = {'black','isort'}, 
                -- Add other languages and fixers as needed
            }
            vim.g.ale_fix_on_save = 1  -- Automatically fix errors on save
        end,
    } 
