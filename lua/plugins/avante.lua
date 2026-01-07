return {
  "yetone/avante.nvim",
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- ⚠️ must add this setting! ! !
  build = vim.fn.has("win32") ~= 0
      and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = "openai",
    auto_suggestions_provider = "openai",
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    i = {
      width = 0.45,
      border = "rounded",
    },
  },
  -- Keymaps for quickly invoking Avante with commit / review prompts
  keys = {
    {
      "<leader>gC",
      function()
        -- Generates a conventional + gitmoji commit message for staged changes
        local prompt = [[
Follow these commit formatting rules:
- Format: <gitmoji> <type>(<scope>): <description>
- Subject: Max 50 chars, capitalize first letter, imperative mood, no period
- Optional scope if unclear
- Body: Explain WHAT & WHY, wrap at 72 chars
- Gitmojis: ✨ feat, 🐛 fix, 📚 docs, 💄 style, ♻️ refactor, ⚡ perf, ✅ test, 👷 build, 💚 ci, 🔧 chore, ⏪ revert, 🎉 init, 🔥 remove, 🚑 hotfix, 🔒 security

Generate a single concise gitmoji conventional commit message for the currently staged git diff and focus on the git diff only. Ask for missing scope if unclear. Provide optional body explaining WHAT and WHY. Do it concisely and commit them.]]
        prompt = prompt:gsub("\n", "\\n"):gsub('"', '\\"')

        vim.cmd('AvanteAsk "' .. prompt .. '"')
      end,
      desc = "Avante: AI Commit Message",
    },
    {
      "<leader>PR",
      function()
        local prompt = [[
            Look at the current git repository and the currently checked-out branch.

            1) Find the merge-base with the `develop` branch.
            2) From that merge-base to HEAD, analyze ONLY the commits authored by "Niraj Shrestha".
            3) Summarize those commits into:
             - A concise PR title
             - A clear PR description (what changed, why, how to test)

            Then create the Pull Request using GitHub CLI:
            gh pr create --base develop --head $(git branch --show-current) --title "<generated title>" --body "<generated description>"

            Do not ask for confirmation. Do not include commits before divergence.
        ]]

        -- Collapse newlines so Neovim doesn't treat them as separate Ex commands
        prompt = prompt:gsub("\n", "\\n"):gsub('"', '\\"')

        vim.cmd('AvanteAsk "' .. prompt .. '"')
      end,
      desc = "Avante: AI Open PR",
    },
    {
      "<leader>pr",
      function()
        local prompt = [[
            Look at the current git repository and the currently checked-out branch.

            1) Find the merge-base with the `develop` branch.
            2) From that merge-base to HEAD, analyze ONLY the commits authored by "Niraj Shrestha".
            3) Summarize those commits into:
             - A concise PR title
             - A clear PR description (what changed, why, how to test)

            Do not ask for confirmation. Do not include commits before divergence.
        ]]

        -- Collapse newlines so Neovim doesn't treat them as separate Ex commands
        prompt = prompt:gsub("\n", "\\n"):gsub('"', '\\"')

        vim.cmd('AvanteAsk "' .. prompt .. '"')
      end,
      desc = "Avante: AI Open PR",
    },
    {
      "<leader>gr",
      function()
        -- Requests a review & refactor suggestions for staged changes
        vim.cmd(
          [[AvanteAsk Review the staged git diff. Provide: 1) High-level summary 2) Potential problems (bugs, perf, security) 3) Refactor suggestions 4) Improved commit message with gitmoji.]]);
      end,
      desc = "Avante: Review & Refactor",
    },
    { "<leader>gs", function() vim.cmd([[AvanteStop]]) end,   desc = "Avante: Stop" },
    { "<leader>gm", function() vim.cmd([[AvanteModels]]) end, desc = "Avante: Models" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick",           -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua",              -- for file_selector provider fzf
    "stevearc/dressing.nvim",        -- for input provider dressing
    "folke/snacks.nvim",             -- for input provider snacks
    "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua",        -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
