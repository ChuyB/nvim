return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
		"https://github.com/mrjones2014/nvim-ts-rainbow",
	},
	config = function()
		local treesitter = require("nvim-treesitter.configs")
		local treesitterI = require("nvim-treesitter.install")

		treesitterI.compilers = { "clang" }

		treesitter.setup({
			highlight = { enable = true },
			indent = { enable = true },
			ensure_installed = {
				"lua",
				"javascript",
				"typescript",
				"haskell",
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
			rainbow = {
				enable = true,
				-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
				extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
				max_file_lines = nil, -- Do not enable for files with more than n lines, int
				-- colors = {}, -- table of hex strings
				-- termcolors = {} -- table of colour name strings
			},
		})
	end,
}
