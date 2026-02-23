local lsp_keymaps = {}

lsp_keymaps.setup = function()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local conform = require("conform")
			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function(args)
					conform.format({
						bufnr = args.buf,
					})
				end,
			})

			local opts = { buffer = event.buf }
			local snacks = require("snacks")

			-- Basic LSP mappings
			snacks.keymap.set("n", "<leader>.", vim.lsp.buf.code_action, {
				desc = "Code Action",
			})
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition()
			end, opts)
			vim.keymap.set("n", "gD", function()
				vim.lsp.buf.declaration()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, opts)
			vim.keymap.set("n", "<leader>dl", function()
				vim.diagnostic.setqflist()
			end, opts)
			vim.keymap.set("n", "gi", function()
				vim.lsp.buf.implementation()
			end, opts)
			vim.keymap.set("n", "go", function()
				vim.lsp.buf.type_definition()
			end, opts)
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "gs", function()
				vim.lsp.buf.signature_help()
			end, opts)
			vim.keymap.set("n", "rn", function()
				vim.lsp.buf.rename()
			end, opts)

			-- Set keymap for buffers with a specific LSP client
			snacks.keymap.set("n", "<C-s>", function()
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = { "source.organizeImports" },
						diagnostics = {},
					},
				})
			end, {
				desc = "Organize Imports",
			})
		end,
	})
end

return lsp_keymaps
