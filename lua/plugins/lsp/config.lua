local lsp_config = {}

lsp_config.setup = function()
	local blink = require("blink.cmp")
	local capabilities = blink.get_lsp_capabilities()

	local function disable_formatting(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end

	require("mason-lspconfig").setup({
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
			"eslint",
		},
		handlers = {
			-- Default handler using vim.lsp
			function(server_name)
				vim.lsp.config(server_name, {
					capabilities = capabilities,
				})
				vim.lsp.enable(server_name)
			end,

			eslint = function()
				vim.lsp.config("eslint", {
					capabilities = capabilities,
					settings = {
						eslint = {
							format = { enable = false },
						},
					},
					on_attach = disable_formatting,
				})
				vim.lsp.enable("eslint")
			end,

			vtsls = function()
				vim.lsp.config("vtsls", {
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
				vim.lsp.enable("vtsls")
			end,

			-- Go LSP configuration
			gopls = function()
				vim.lsp.config("gopls", {
					capabilities = capabilities,
					settings = {
						gopls = {
							gofumpt = true,
							staticcheck = true,
							analyses = { unusedparams = true },
						},
					},
				})
				vim.lsp.enable("gopls")
			end,

			-- Lua LSP configuration
			lua_ls = function()
				vim.lsp.config("lua_ls", {
					cmd = { "lua-language-server" },
					filetypes = { "lua" },
					root_markers = {
						".luarc.json",
						".luarc.jsonc",
						".luacheckrc",
						".stylua.toml",
						".git",
					},
					settings = {
						Lua = {
							runtime = {
								version = "Lua 5.3",
								path = {
									"?.lua",
									"?/init.lua",
									vim.fn.expand("~/.luarocks/share/lua/5.3/?.lua"),
									vim.fn.expand("~/.luarocks/share/lua/5.3/?/init.lua"),
									"/usr/share/5.3/?.lua",
									"/usr/share/lua/5.3/?/init.lua",
								},
							},
							workspace = {
								library = {
									vim.fn.expand("~/.luarocks/share/lua/5.3"),
									"/usr/share/lua/5.3",
								},
							},
						},
					},
				})

				-- Now that the language server is configured, it must be enabled
				vim.lsp.enable("lua_ls")
				vim.lsp.enable("lua_ls")
			end,

			-- OmniSharp LSP configuration
			omnisharp = function()
				vim.lsp.enable("omnisharp")
				vim.lsp.config("omnisharp", {
					capabilities = capabilities,
					handlers = {
						["textDocument/definition"] = require("omnisharp_extended").definition_handler,
						["textDocument/typeDefinition"] = require("omnisharp_extended").type_definition_handler,
						["textDocument/references"] = require("omnisharp_extended").references_handler,
						["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
					},
				})
			end,
		},
		automatic_installation = true,
	})
end

return lsp_config
