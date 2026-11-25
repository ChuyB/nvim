return {
	{
		"williamboman/mason.nvim",
		opts = {},
	},
	{
		"nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
		build = ":TSUpdate",
		config = function()
			local treesitter = require("nvim-treesitter")
			treesitter.setup()
			treesitter.install({
				"lua", "luadoc", "luap", "luau", "java", "javascript", "typescript", "tsx",
				"css", "html", "markdown", "markdown_inline", "python", "vimdoc", "vim",
				"c", "cmake", "svelte",
			})
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(ev)
					local lang = vim.treesitter.language.get_lang(ev.match) or ev.match
					if pcall(vim.treesitter.start, ev.buf, lang) then
						vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
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
			-- local completion = null_ls.builtins.completion

			-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
					formatting.stylua,
					formatting.prettierd,
					formatting.black,
					formatting.google_java_format,
					formatting.clang_format,
					formatting.gofumpt,
				},
			})
		end,
	},
}
