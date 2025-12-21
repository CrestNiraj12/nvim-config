local lsp_config = {}

lsp_config.setup = function()
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
    },
    handlers = {
      -- Default handler using vim.lsp
      function(server_name)
        vim.lsp.enable(server_name)
        vim.lsp.config(server_name, {
          capabilities = require('blink.cmp').get_lsp_capabilities(),
        })
      end,

      -- Lua LSP configuration
      lua_ls = function()
        vim.lsp.enable('lua_ls')
        vim.lsp.config('lua_ls', {
          capabilities = require('blink.cmp').get_lsp_capabilities(),
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
          capabilities = require('blink.cmp').get_lsp_capabilities(),
          handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
            ["textDocument/references"] = require('omnisharp_extended').references_handler,
            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
          },
        })
      end,

      -- Disable pyright - Python uses ALE instead
      pyright = function()
        -- Do nothing - Python formatting/fixing is handled by ALE
      end,
    },
    automatic_installation = true,
  })
end

return lsp_config
