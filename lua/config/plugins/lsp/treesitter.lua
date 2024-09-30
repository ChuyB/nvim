return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local treesitterI = require("nvim-treesitter.install")

		treesitterI.compilers = { "clang" }

		treesitter.setup({
			highlight = { enable = true, disable = { "lua" } },
			indent = { enable = true, disable = { "lua" } },
			auto_install = true,
			ensure_installed = {
				"lua",
				"luadoc",
				"luap",
				"luau",
				"java",
				"javascript",
				"typescript",
				"tsx",
				"css",
				"html",
				"markdown",
				"markdown_inline",
				"python",
				"vimdoc",
				"vim",
				"c",
				"cmake",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},
		})
	end,
}
