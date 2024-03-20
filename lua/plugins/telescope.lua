return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{
			"nvim-telescope/telescope-ui-select.nvim",
			opts = {},
		}
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown {}
				}
			},
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					}
				}
			}
		})

		telescope.load_extension("fzf")
		telescope.load_extension("ui-select")

		local builtin = require("telescope.builtin")
		local k = vim.keymap
		-- Update these lines to include file_ignore_patterns in the options
		k.set("n", "<leader>ff", function() builtin.find_files({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		k.set("n", "<leader>fg", function() builtin.live_grep({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		k.set("n", "<leader>fb", builtin.buffers, {})
		k.set("n", "<leader>fh", builtin.help_tags, {})
		k.set("n", "<leader>fo", builtin.oldfiles, {})
		k.set("n", "<leader>fk", builtin.keymaps, {})
		k.set("n", "<leader>fc", builtin.commands, {})
		k.set("n", "<leader>fm", builtin.marks, {})
		k.set("n", "<leader>ft", function() builtin.current_buffer_fuzzy_find({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		k.set("n", "<leader>fs", function() builtin.lsp_document_symbols({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		k.set("n", "<leader>fw", function() builtin.lsp_workspace_symbols({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		k.set("n", "<leader>fd", function() builtin.lsp_definitions({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		k.set("n", "<leader>fi", function() builtin.lsp_implementations({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		k.set("n", "<leader>fr", function() builtin.lsp_references({ file_ignore_patterns = { "migrations/.*" } }) end, {})
		-- Registers
		k.set("n", "<leader>fz", builtin.registers, {})
	end
}
