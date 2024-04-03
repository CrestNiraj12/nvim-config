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
          exception_breakpoints = {},
          register_configurations = function(_)
            require("dap").configurations.dart = {
              {
                type = 'flutter',
                request = 'launch',
                name = 'Flutter Debug',
                flutterMode = 'debug',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                toolArgs = { '--flavor', 'dev' },
              },
              {
                type = 'flutter',
                request = 'launch',
                name = 'Flutter Debug Prod',
                flutterMode = 'debug',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                toolArgs = { '--flavor', 'prod' },
              }
            }
            -- require("dap.ext.vscode").load_launchjs()
          end
        },
        outline = { auto_open = false },
        decorations = {
          statusline = { device = true, app_version = true },
        },
        widget_guides = { enabled = true, debug = true },
        dev_log = {
          enabled = true,
          notify_errors = true,
          open_cmd = "tabedit",
        },
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
      function _G.statusLine()
        return vim.g.flutter_tools_decorations.app_version
      end

      vim.opt.statusline = '%!v:statusLine()'
    end
  },
}
