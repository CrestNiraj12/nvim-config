return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require('gitsigns').setup {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				local gs = package.loaded.gitsigns

				-- Navigation
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', ']c', '<cmd>lua require"gitsigns".next_hunk()<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '[c', '<cmd>lua require"gitsigns".prev_hunk()<CR>', {silent = true, noremap = true})
				--
				-- -- Actions
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>hs', '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk()<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>hr', '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hS', '<cmd>lua require"gitsigns".stage_buffer()<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hu', '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hR', '<cmd>lua require"gitsigns".reset_buffer()<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hp', '<cmd>lua require"gitsigns".preview_hunk()<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line(true)<CR>', {silent = true, noremap = true})
				-- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>hd', '<cmd>lua require"gitsigns".diffthis()<CR>', {silent = true, noremap = true})
				-- -- More mappings can be added here
			end,
		}
	end,
}
