return {
  {
    "github/copilot.vim",
		event = { "BufReadPre", "BufNewFile" },
  },
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"https://github.com/echasnovski/mini.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local cursorword = require("mini.cursorword")
			local comments = require("mini.comment")
			local hipatterns = require("mini.hipatterns")
			local indentscope = require("mini.indentscope")
			local surround = require("mini.surround")

			surround.setup()
			cursorword.setup()
			comments.setup({
				mappings = {
					-- Toggle comment (like `gcip` - comment inner paragraph) for both
					-- Normal and Visual modes
					comment = "gc",
					-- Toggle comment on current line
					comment_line = "gcc",
					-- Toggle comment on visual selection
					comment_visual = "gc",
					-- Define 'comment' textobject (like `dgc` - delete whole comment block)
					textobject = "gc",
				},
			})
			indentscope.setup({
				draw = {
					delay = 50,
				},
				symbol = "│",
			})
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})

			-- NOTE: Changes cursorword and indentscope colors and visuals
			vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })
			vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#3b4048" })
		end,
	},
	{
		"folke/zen-mode.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			plugins = {
				wezterm = {
					enabled = true,
					font = "+4",
				},
			},
		},
	},
}
