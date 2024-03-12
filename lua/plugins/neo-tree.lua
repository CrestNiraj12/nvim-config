return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ '<C-n>',      "<cmd>Neotree toggle position=right <CR>",                       desc = "Toggle Neo-tree" },
		-- Focus --
		{ '<leader>nf', "<cmd>Neotree focus <CR>",                                      desc = "Focus Neo-tree" },
		{ '<leader>nd', "<cmd>Neotree toggle position=right reveal_force_cwd=true <CR>", desc = "Toggle Neo-tree and reveal current file" },
		{ '<leader>nb', "<cmd>Neotree toggle position=right source=buffers <CR>",        desc = "Toggle Neo-tree with buffer list" },
		-- You can add more mappings as needed
	},
	config = function()
		local neotree = require("neo-tree")
		neotree.setup({
			filesystem = {
				filtered_items = {
					visible = true, -- hide just means dimmed
					hide_dotfiles = false,
					hide_gitignored = true,
				}
			}
		})
	end
}
