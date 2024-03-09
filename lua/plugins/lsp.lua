return {
	{
		'williamboman/mason.nvim',
		lazy = false,
		config = true,
	},
	{
		'neovim/nvim-lspconfig',
		cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{
				"nvimtools/none-ls.nvim",
				config = function()
					local null_ls = require("null-ls")
					null_ls.setup({
						sources = {
							null_ls.builtins.code_actions.gitsigns,
						},
					})
				end,
			},
		},
		config = function()
			-- lsp keybindings
			vim.api.nvim_create_autocmd('LspAttach', {
				desc = 'LSP actions',
				callback = function(event)
					local opts = { buffer = event.buf }

					-- these will be buffer-local keybindings
					-- because they only work if you have an active language server

					vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
					vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
					vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
					vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
					vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
					vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
					vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
					vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
					vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
					vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)

					-- override defaults from lsp_zero
					vim.keymap.set("n", "<leader>ca", '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
					-- code formatting
					vim.keymap.set("n", "<leader>mp", function()
						vim.lsp.buf.format({})
					end)
				end
			})

			-- hover borders
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

			local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

			local on_attach = function(client, bufnr)
				local bufopts = { noremap=true, silent=true, buffer=bufnr }
			end

			local default_setup = function(server)
				require('lspconfig')[server].setup({
					capabilities = lsp_capabilities,
					on_attach = on_attach,
				})
			end

			require('mason-lspconfig').setup({
				ensure_installed = {
					"jdtls",
					"html",
					"pyright",
					"jsonls",
					"pyre",
					"rust_analyzer",
					"taplo",
					"marksman",
					"sourcery",
				},
				handlers = {
					default_setup,
					lua_ls = function()
						require('lspconfig').lua_ls.setup({
							settings = {
								Lua = {
									diagnostics = {
										globals = { "vim" },
									},
									workspace = {
										library = {
											[vim.fn.expand("$VIMRUNTIME/lua")] = true,
											[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
										},
									},
								},
							},
						})
					end,
				},
				automatic_installation = true,
			})
		end
	}
}
