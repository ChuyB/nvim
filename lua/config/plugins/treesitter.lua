return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local treesitterI = require("nvim-treesitter.install")

		treesitterI.compilers = { "clang" }

		treesitter.setup({
			highlight = { enable = true },
			indent = { enable = true },
			--auto_install = true,
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"tsx",
				"css",
				"html",
				"markdown",
				"markdown_inline",
				"java",
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
