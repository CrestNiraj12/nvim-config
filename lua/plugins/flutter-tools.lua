return {
  {
    'akinsho/flutter-tools.nvim',
    lazy = false,
    event = { "BufReadPre", "BufNewFile" },
    ft = { "dart" },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require("flutter-tools").setup({
        fvm = true,
        flutter_lookup_cmd = "asdf where flutter",
        debugger = {
          enabled = true,
          run_via_dap = true,
          exception_breakpoints = { "uncaught" },
          register_configurations = function(_)
            -- require("dap.ext.vscode").load_launchjs()
          end
        },
        outline = { auto_open = false },
        decorations = {
          statusline = { device = true, app_version = true },
        },
        widget_guides = { enabled = true, debug = true },
        dev_log = { enabled = true, open_cmd = "tabedit" },
        lsp = {
          color = {
            enabled = true,
            background = true,
            virtual_text = false,
          },
          settings = {
            showTodos = true,
            renameFilesWithClasses = "prompt",
            updateImportsOnRename = true,
            completeFunctionCalls = true,
            enableSnippets = true,
          },
        },
      })
    end
  },
}
