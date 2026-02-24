return {
	"folke/edgy.nvim",
	event = "VeryLazy",
	init = function()
		vim.opt.laststatus = 3
		vim.opt.splitkeep = "screen"
	end,

	opts = function(_, opts)
		-- If you already had opts from elsewhere, keep them and extend.
		opts.animate = { enabled = false }

		opts.left = {
			{
				title = "Explorer",
				ft = { "snacks_picker_list", "snacks_picker_input" },
				size = { width = 32, height = 0.5 },
				pinned = true,
				collapsed = false,
				open = function()
					Snacks.explorer()
				end,
			},
			{
				title = "Outline",
				ft = "outline",
				size = { width = 32, height = 0.5 },
				pinned = true,
				collapsed = false,
				open = function()
					vim.cmd("Outline")
				end,
			},
		}

		opts.bottom = {
			{
				title = "Trouble",
				ft = "trouble",
				size = { height = 12 },
				open = function()
					vim.cmd("Trouble diagnostics toggle")
				end,
			},
			{
				title = "QuickFix",
				ft = "qf",
				size = { height = 10 },
				open = function()
					vim.cmd("copen")
				end,
			},
		}

		opts.right = {
			{ ft = "spectre_panel", title = "Spectre", size = { width = 60 } },
			{
				title = "Avante",
				ft = { "Avante", "AvanteInput", "AvanteTodos", "AvanteSelectedCode", "AvanteSelectedFiles" },
				size = { width = 50 },
			},
		}

		opts.top = {
			{
				ft = "help",
				title = "Help",
				size = { height = 10 },
				filter = function(buf)
					return vim.bo[buf].buftype == "help"
				end,
			},
		}

		for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
			opts[pos] = opts[pos] or {}
			table.insert(opts[pos], {
				ft = "snacks_terminal",
				title = "%{b:snacks_terminal.id}: %{b:term_title}",
				size = (pos == "left" or pos == "right") and { width = 32 } or { height = 0.4 },

				filter = function(_buf, win)
					return vim.w[win].snacks_win
						and vim.w[win].snacks_win.position == pos
						and vim.w[win].snacks_win.relative == "editor"
						and not vim.w[win].trouble_preview
				end,
			})
		end

		return opts
	end,

	keys = {
		{
			"<leader>E",
			function()
				require("edgy").toggle("left")
			end,
			desc = "Edgy: Toggle Left",
		},
		{
			"<leader>B",
			function()
				require("edgy").toggle("bottom")
			end,
			desc = "Edgy: Toggle Bottom",
		},
		{
			"<leader>T",
			function()
				require("edgy").toggle("top")
			end,
			desc = "Edgy: Toggle Top",
		},
		{
			"<leader>R",
			function()
				require("edgy").toggle("right")
			end,
			desc = "Edgy: Toggle Right",
		},
		{
			"<leader>M",
			function()
				require("edgy").goto_main()
			end,
			desc = "Edgy: Go to main",
		},
	},
}
