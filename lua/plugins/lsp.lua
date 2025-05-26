local isInitialized = false
local devicesFetched = false

local force_format_clients = {
  dartls = true,
  lua_ls = true,
}

return {
  {
    'mason-org/mason.nvim',
    lazy = false,
    config = true,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      { 'saghen/blink.cmp' },
      {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
          { "mason-org/mason.nvim" },
        },
      },
    },
    config = function()
      local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()

      local default_setup = function(server)
        vim.lsp.config(server, {
          capabilities = lsp_capabilities,
        })
      end


      require('mason-lspconfig').setup({
        ensure_installed = {
          "gopls",
          "jdtls",
          "lua_ls",
          "html",
          "pyright",
          "jsonls",
          "rust_analyzer",
          "taplo",
          "sourcery",
          "ts_ls",
        },
        handlers = {
          default_setup,
          vim.lsp.config("lua_ls", {
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' },
                },
                workspace = {
                  library = {
                    vim.env.VIMRUNTIME,
                  },
                  checkThirdParty = false,
                },
                telemetry = {
                  enable = false, -- Do not send telemetry data
                },
              },
            },
          }),
          sourcery = function()
            vim.lsp.config("sourcery", {
              init_options = {
                --- The Sourcery token for authenticating the user.
                --- This is retrieved from the Sourcery website and must be
                --- provided by each user. The extension must provide a
                --- configuration option for the user to provide this value.
                token = os.getenv('SOURCERY_TOKEN'),

                --- The extension's name and version as defined by the extension.
                extension_version = 'vim.lsp',

                --- The editor's name and version as defined by the editor.
                editor_version = 'vim',
              }
            })
          end,
        },
        automatic_installation = true,
        automatic_enable = false,
      })


      local devices = require('user.flutter.devices')
      if (not isInitialized) then
        vim.api.nvim_create_autocmd("LspAttach", {
          pattern = "*.dart",
          callback = function(event)
            local buf = event.buf;

            if not devicesFetched then
              devices.fetch(function()
                devicesFetched = true
                vim.notify("Devices fetched!")
              end)
            end


            vim.api.nvim_create_user_command('FlutterDevices', function()
              if vim.tbl_isempty(devices.get_devices()) then
                devices.fetch(function()
                  vim.notify("Devices refreshed!\n" .. vim.inspect(devices.get_devices()))
                end)
              else
                print(vim.inspect(devices.get_devices()))
              end
            end, { desc = "Show cached Flutter devices" })

            local flutter_telescope = require('user.flutter.telescope')
            vim.keymap.set('n', '<leader>d', flutter_telescope.picker, {
              buffer = buf,
              desc = "Select Flutter device"
            })

            vim.keymap.set('n', '<leader>fR', function()
              vim.notify("Refreshing devices!")
              devices.fetch(function()
                vim.notify("Devices refreshed!")
              end)
            end, { buffer = buf, desc = "Refresh Flutter devices" })

            isInitialized = true
          end
        })
      end

      -- lsp keybindings
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local opts = {
            buffer = event.buf
          }

          -- these will be buffer-local keybindings
          -- because they only work if you have an active language server

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
          vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
          vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
          vim.keymap.set('n', '<leader>dl', '<cmd>lua vim.diagnostic.setqflist()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set({ 'n', 'x' }, "<leader>.", '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

          local function has_formatting(client)
            return
                client.server_capabilities
                and client.server_capabilities.documentFormattingProvider
                or force_format_clients[client.name] == true
          end

          -- Define a function to organize imports and formatlsp.
          local function organize_and_format()
            local bufnr = vim.api.nvim_get_current_buf()

            -- Check if any attached client supports formatting
            local has_lsp_formatter = false
            for _, client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
              has_lsp_formatter = has_formatting(client)
            end


            -- Run appropriate formatter
            if has_lsp_formatter then
              vim.lsp.buf.format({ async = true })
            else
              vim.cmd("ALEFix")
            end

            -- Request code action to organize imports
            if vim.bo.filetype == 'dart' then
              vim.lsp.buf.code_action({
                context = {
                  diagnostics = {},
                  only = { "source.organizeImports", },
                },
                apply = true
              })
            end
          end

          -- Bind the organize and format function to <C-s> keymap
          vim.keymap.set('n', '<C-s>', organize_and_format, { desc = 'Format and Organize Imports' })
        end
      })
    end
  }
}
