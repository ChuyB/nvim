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
		--- Hipatterns ----

		-- Returns hex color group for matching 0xAARRGGBB (ignoring alpha)
		--
		---@param match string
		---@return string
		local hex_color_0x = function(_, match)
			local style = "fg" -- 'fg' or 'bg'
			-- Extract RRGGBB from 0xAARRGGBB
			local rr, gg, bb = match:match("0x%x%x(%x%x)(%x%x)(%x%x)")
			local hex = string.format("#%s%s%s", rr, gg, bb)
			return hipatterns.compute_hex_color_group(hex, style)
		end

		-- Returns hex color group for matching short hex color.
		--
		---@param match string
		---@return string
		local hex_color_short = function(_, match)
			local style = "fg" -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
			local r, g, b = match:sub(2, 2), match:sub(3, 3), match:sub(4, 4)
			local hex = string.format("#%s%s%s%s%s%s", r, r, g, g, b, b)
			return hipatterns.compute_hex_color_group(hex, style)
		end

		-- Returns hex color group for matching rgb() color.
		--
		---@param match string
		---@return string
		local rgb_color = function(_, match)
			local style = "fg" -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
			local red, green, blue = match:match("rgb%((%d+), ?(%d+), ?(%d+)%)")
			local hex = string.format("#%02x%02x%02x", red, green, blue)
			return hipatterns.compute_hex_color_group(hex, style)
		end

		-- Returns hex color group for matching rgba() color
		-- or false if alpha is nil or out of range.
		-- The use of the alpha value refers to a black background.
		--
		---@param match string
		---@return string|false
		local rgba_color = function(_, match)
			local style = "fg" -- 'fg' or 'bg', for extmark_opts_inline use 'fg'
			local red, green, blue, alpha = match:match("rgba%((%d+), ?(%d+), ?(%d+), ?(%d*%.?%d*)%)")
			alpha = tonumber(alpha)
			if alpha == nil or alpha < 0 or alpha > 1 then
				return false
			end
			local hex = string.format("#%02x%02x%02x", red * alpha, green * alpha, blue * alpha)
			return hipatterns.compute_hex_color_group(hex, style)
		end

		-- Returns extmark opts for highlights with virtual inline text.
		--
		---@param data table Includes `hl_group`, `full_match` and more.
		---@return table
		local extmark_opts_inline = function(_, _, data)
			return {
				virt_text = { { "", data.hl_group } },
				virt_text_pos = "inline",
				-- priority = 200,
				right_gravity = false,
			}
		end
		hipatterns.setup({
			highlighters = {
				-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

				-- Highlight hex color strings (`#rrggbb`) using that color
				-- hex_color = hipatterns.gen_highlighter.hex_color({ style = 'full' }),
				hex_color = hipatterns.gen_highlighter.hex_color({ style = "inline", inline_text = "" }),
				-- `#rgb`
				hex_color_short = {
					pattern = "#%x%x%x%f[%X]",
					group = hex_color_short,
					extmark_opts = extmark_opts_inline,
				},
				-- `rgb(255, 255, 255)`
				rgb_color = {
					pattern = "rgb%(%d+, ?%d+, ?%d+%)",
					group = rgb_color,
					extmark_opts = extmark_opts_inline,
				},
				-- `rgba(255, 255, 255, 0.5)`
				rgba_color = {
					pattern = "rgba%(%d+, ?%d+, ?%d+, ?%d*%.?%d*%)",
					group = rgba_color,
					extmark_opts = extmark_opts_inline,
				},
				-- `0xAARRGGBB` (ignores alpha)
				hex_color_0x = {
					pattern = "0x%x%x%x%x%x%x%x%x%f[%X]",
					group = hex_color_0x,
					extmark_opts = extmark_opts_inline,
				},
			},
		})

		-- NOTE: Changes cursorword and indentscope colors and visuals
		vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
		vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })
		vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#9f9f9f" })
	end,
}
