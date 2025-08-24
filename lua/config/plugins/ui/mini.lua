
return {
	"echasnovski/mini.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local cursorword = require("mini.cursorword")
		local pairs = require("mini.pairs")
		local comments = require("mini.comment")
		local hipatterns = require("mini.hipatterns")
		local surround = require("mini.surround")
		local indent = require("mini.indentscope")

		surround.setup()
		cursorword.setup()
		pairs.setup()
		indent.setup({
			symbol = "│",
		})
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
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#9f9f9f" })
	end,
}
