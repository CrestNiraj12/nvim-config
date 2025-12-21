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
      -- Default handler using lspconfig
      function(server_name)
        local lspconfig = require('lspconfig')
        lspconfig[server_name].setup({
          capabilities = require('blink.cmp').get_lsp_capabilities(),
        })
      end,

      -- Lua LSP configuration
      lua_ls = function()
        require('lspconfig').lua_ls.setup({
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
        require('lspconfig').omnisharp.setup({
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
