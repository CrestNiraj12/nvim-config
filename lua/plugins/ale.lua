return {
  "dense-analysis/ale",
  event = "BufRead", -- Adjust the event for when you want ALE to load
  config = function()
    -- ALE basic configuration
    vim.g.ale_lint_on_enter = 1              -- Lint files when they are opened
    vim.g.ale_lint_on_text_changed = 'never' -- Lint files as you type
    vim.g.ale_maximum_processes = 4
    vim.g.ale_linters_explicit = 1
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
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      typescriptreact = { "eslint" },
      -- Add other languages and linters as needed
    }

    -- Example: Enable ALE fixers
    vim.g.ale_fixers = {
      dart = {},
      python = { 'black', 'isort' },
      css = { 'prettier' },
      cs = { 'clang-format', 'remove_trailing_lines', 'trim_whitespace' },
      javascript = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      json = { 'prettier' },
      html = { 'prettier' },
    }
  end,
}
