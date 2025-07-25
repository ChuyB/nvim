return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
		config = function()
			local treesitter = require("nvim-treesitter.configs")
			treesitter.setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
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
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		keys = {
			{
				"<leader>fm",
				function()
					vim.lsp.buf.format()
				end,
				desc = "Format code",
			},
		},
		config = function()
			local null_ls = require("null-ls")

			local formatting = null_ls.builtins.formatting
			local lint = null_ls.builtins.diagnostics
			local completion = null_ls.builtins.completion

			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					formatting.stylua,
					formatting.prettierd,
					formatting.google_java_format,
					formatting.clang_format,
					formatting.gofumpt,
				},
			})
		end,
	},
}
