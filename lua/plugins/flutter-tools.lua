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
        ui = {
          notification_style = 'minimized',
        },
        decorations = {
          statusline = {
            app_version = true,
            device = true,
          }
        },
        fvm = true,
        flutter_path = "/Users/niraj.shrestha/flutter/bin/flutter",
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
              },
              {
                type = 'flutter',
                request = 'launch',
                name = 'Flutter DEV Debug',
                flutterMode = 'debug',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                toolArgs = { '--flavor', 'dev' },
              },
              {
                type = 'flutter',
                request = 'launch',
                name = 'Flutter DEV Release',
                flutterMode = 'release',
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
                toolArgs = { '--flavor', 'dev', '--release' },
              },
              {
                type = 'flutter',
                request = 'launch',
                name = 'Flutter DEV Debug Prod',
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
            require("dap.ext.vscode").load_launchjs()
          end
        },
        dev_tools = {
          auto_open_browser = true,
        },
        outline = { auto_open = false },
        widget_guides = { enabled = false, debug = false, },
        root_patterns = { ".git", "pubspec.yaml" },
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
