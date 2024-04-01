return {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      keys = {
        { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle DAP UI" },
      },
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)

        dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close({}) end
        dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end
      end
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      config = function()
        require("nvim-dap-virtual-text").setup({
          -- Customize virtual text appearance here
        })
      end
    },
    {
      "jay-babu/mason-nvim-dap.nvim",
      dependencies = "williamboman/mason.nvim",
      config = function()
        require("mason-nvim-dap").setup({
          automatic_setup = true,
          ensure_installed = { "debugpy" }, -- Add or remove debug adapters as needed
        })
      end
    },
  },
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end,          desc = "Continue" },
    { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over" },
    { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end,  desc = "Inspect Variable" },
    { "<leader>dr", function() require("dap").repl.open() end,         desc = "Open REPL" },
    { "<leader>dp", function() require("dap").run_to_cursor() end,     desc = "Run to Cursor" },
    { "<leader>dq", function() require("dap").terminate() end,         desc = "Terminate Debug Session" },
  },
  config = function()
    local dap = require("dap")
    dap.adapters.python = {
      type = "executable",
      command = "python",
      args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
      {
        -- Adjust this configuration to fit the project's environment
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          -- Automatically select the Python interpreter based on the project's environment
          -- Example for virtualenv or any other environment tool
          local cwd = vim.fn.getcwd()
          if vim.fn.filereadable(cwd .. "/.venv/bin/python") == 1 then
            return cwd .. "/.venv/bin/python"
          else
            return vim.fn.exepath("python")
          end
        end,
      },
      {
        type = 'python',
        request = 'launch',
        name = 'Django Test',
        program = '${workspaceFolder}/manage.py', -- Adjust if your manage.py is located differently
        args = function()
          -- Prompt for the specific test to run, e.g., "app.tests.TestCase"
          local test_spec = vim.fn.input('Test spec (e.g., app.tests.TestCase): ')
          return { 'test', test_spec }
        end,
        pythonPath = function()
          -- Adjust this to the path of the Python interpreter you're using
          return vim.fn.exepath('python')
        end,
        justMyCode = true, -- Set to false to debug through Django and other libraries' code
        django = true,
      },
    }

    -- Set up the DAP adapter and configuration for Flutter
    dap.adapters.dart = {
      type = 'executable',
      command = 'flutter',
      args = { 'debug_adapter' },
    }

    dap.configurations.dart = {
      {
        type = 'dart',
        request = 'launch',
        name = 'Flutter Debug',
        flutterMode = 'debug',
        program = "${workspaceFolder}/lib/main.dart",
        cwd = "${workspaceFolder}",
        toolArgs = { '--flavor', 'dev' }, -- Specify the flavor here
      },
    }
  end
}
