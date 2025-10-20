return {
  "dense-analysis/ale",
  event = "BufRead", -- Adjust the event for when you want ALE to load
  config = function()
    -- ALE basic configuration
    vim.g.ale_lint_on_enter = 1               -- Lint files when they are opened
    vim.g.ale_lint_on_save = 1                -- Lint files when they are saved
    vim.g.ale_fix_on_save = 1                 -- Automatically fix issues on save
    vim.g.ale_lint_on_text_changed = 'always' -- Lint files as you type
    vim.g.ale_javascript_prettier_use_local_config = 1

    -- Additional ALE settings...
    -- Set up any ALE linters, fixers, or other options as needed
    -- Example: Enable specific linters
    vim.g.ale_linters = {
      python = { 'flake8' },
      dart = {},
      json = { 'jsonls' },
      yaml = { 'yamlls' },
      xml = { 'lemminx' },
      -- Add other languages and linters as needed
    }

    -- Example: Enable ALE fixers
    vim.g.ale_fixers = {
      dart = {},
      python = { 'black', 'ruff_format', 'isort' },
      css = { 'prettier' },
      cs = { 'clang-format', 'remove_trailing_lines', 'trim_whitespace' },
      javascript = { "eslint", "prettier" },
      ypescript = { "eslint", "prettier" },
      typescriptreact = { "eslint", "prettier" },
      json = { 'prettier' },
      html = { 'prettier' },
    }
  end,
}
