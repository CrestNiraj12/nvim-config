local lsp_config = {}

lsp_config.setup = function()
  local blink = require('blink.cmp')
  local capabilities = blink.get_lsp_capabilities()

  local function disable_formatting(client)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  require('mason-lspconfig').setup({
    ensure_installed = {
      "gopls",
      "jdtls",
      "lua_ls",
      "html",
      "jsonls",
      "rust_analyzer",
      "tailwindcss",
      "omnisharp",
      "vtsls",
      "pyright",
      "ruff",
      "eslint"
    },
    handlers = {
      -- Default handler using vim.lsp
      function(server_name)
        vim.lsp.enable(server_name)
        vim.lsp.config(server_name, {
          capabilities = capabilities,
        })
      end,

      eslint = function()
        vim.lsp.enable('eslint')
        vim.lsp.config('eslint', {
          capabilities = capabilities,
          settings = {
            eslint = {
              format = { enable = false }
            },
          },
          on_attach = disable_formatting,
        })
      end,

      vtsls = function()
        vim.lsp.enable('vtsls')
        vim.lsp.config('vtsls', {
          capabilities = capabilities,
          settings = {
            typescript = {
              format = { enable = false },
            },
            javascript = {
              format = { enable = false },
            },
          },
          on_attach = disable_formatting,
        })
      end,

      -- Go LSP configuration
      gopls = function()
        vim.lsp.enable('gopls')
        vim.lsp.config('gopls', {
          capabilities = capabilities,
          settings = {
            gopls = {
              gofumpt = true,
              staticcheck = true,
              analyses = { unusedparams = true },
            },
          },
        })
      end,

      -- Lua LSP configuration
      lua_ls = function()
        vim.lsp.enable('lua_ls')
        vim.lsp.config('lua_ls', {
          capabilities = capabilities,
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
                enable = false,
              },
            },
          },
        })
      end,

      -- OmniSharp LSP configuration
      omnisharp = function()
        vim.lsp.enable('omnisharp')
        vim.lsp.config('omnisharp', {
          capabilities = capabilities,
          handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
            ["textDocument/references"] = require('omnisharp_extended').references_handler,
            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
          },
        })
      end,
    },
    automatic_installation = true,
  })
end

return lsp_config
