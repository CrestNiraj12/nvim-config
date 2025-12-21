local lsp_config = {}

lsp_config.setup = function()
  require('mason-lspconfig').setup({
    ensure_installed = {
      "gopls",
      "jdtls",
      "lua_ls",
      "html",
      "pyright",
      "jsonls",
      "rust_analyzer",
      "tailwindcss",
      "omnisharp",
    },
    handlers = {
      lua_ls = function()
        require('lspconfig').lua_ls.setup({
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
        })
      end,
      omnisharp = function()
        require('lspconfig').omnisharp.setup({
          handlers = {
            ["textDocument/definition"] = require('omnisharp_extended').definition_handler,
            ["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler,
            ["textDocument/references"] = require('omnisharp_extended').references_handler,
            ["textDocument/implementation"] = require('omnisharp_extended').implementation_handler,
          },
        })
      end,
      -- Disable Ruff LSP since we use it via ALE
      ruff = function()
        -- Do nothing - Ruff is handled by ALE, not as an LSP
      end,
    },
    automatic_installation = true,
  })

  local lsp_capabilities = require('blink.cmp').get_lsp_capabilities()
  vim.lsp.config.default = {
    capabilities = lsp_capabilities,
  }
end

return lsp_config
