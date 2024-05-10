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
        flutter_lookup_cmd = "dirname $(which flutter)",
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
              },
              {
                type = 'flutter',
                request = 'launch',
                name = 'Flutter Profile Dev',
                flutterMode = 'profile',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                toolArgs = { '--flavor', 'dev' },
              },
              {
                type = 'flutter',
                request = 'launch',
                name = 'Flutter Profile Prod',
                flutterMode = 'profile',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                toolArgs = { '--flavor', 'prod' },
              }

            }
            -- require("dap.ext.vscode").load_launchjs()
          end
        },
        dev_tools = {
          auto_open_browser = true,
        },
        outline = { auto_open = false },
        widget_guides = { enabled = true, debug = true },
        dev_log = {
          enabled = false,
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
            analysisExcludedFolders = {
              "build",
              "android",
              "ios",
              "~/.pub-cache"
            }
          },
        },
      })
    end
  },
}
