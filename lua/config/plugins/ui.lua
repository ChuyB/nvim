return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{
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
	},
	{
		"folke/noice.nvim",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
		},
		config = function()
			local noice = require("noice")

			noice.setup({
				views = {
					mini = {
						win_options = {
							winblend = 0,
						},
					},
				},
				lsp = {
					progress = {
						enabled = false,
					},
					-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
						["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
					},
				},
				-- you can enable a preset for easier configuration
				presets = {
					bottom_search = true, -- use a classic bottom cmdline for search
					command_palette = true, -- position the cmdline and popupmenu together
					long_message_to_split = true, -- long messages will be sent to a split
					inc_rename = false, -- enables an input dialog for inc-rename.nvim
					lsp_doc_border = true, -- adds a border to the lsp doc
				},
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			input = { enabled = true },
			quickfile = { enabled = true },
			picker = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			styles = {
				input = {
					backdrop = 60,
				},
				notification = {
					wo = {
						winblend = 0,
						wrap = true,
					},
				},
			},
		},
		keys = {
			-- Keymaps
			-- Files
			{
				"<leader><space>",
				function()
					Snacks.picker.smart()
				end,
				desc = "Smart find files",
			},
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>fg",
				function()
					Snacks.picker.git_files()
				end,
				desc = "Git files",
			},
			{
				"<leader>lg",
				function()
					Snacks.picker.grep()
				end,
				desc = "Live grep",
			},
			{
				"<leader>sk",
				function()
					Snacks.picker.keymaps()
				end,
				desc = "Show keymaps",
			},
			-- LSP
			{
				"gd",
				function()
					Snacks.picker.lsp_definitions()
				end,
				desc = "Goto definition",
			},
			{
				"gD",
				function()
					Snacks.picker.lsp_declarations()
				end,
				desc = "Goto declarations",
			},
			{
				"grr",
				function()
					Snacks.picker.lsp_references()
				end,
				desc = "Goto references",
			},
			-- Generals
			{
				"<leader>gg",
				function()
					Snacks.lazygit()
				end,
				desc = "Open LazyGit",
			},
			{
				"<leader>nd",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Hide notifications",
			},
			{
				"<leader>gb",
				function()
					Snacks.gitbrowse()
				end,
				desc = "Go to git repository",
			},
			{
				"<leader>nh",
				function()
					Snacks.notifier.hide()
				end,
				desc = "Dismiss notifications",
			},
		},
		init = function()
			local ns = vim.api.nvim_create_namespace("bufwrite_msgs")
			-- Temp fix to send message on save
			vim.ui_attach(ns, { ext_popupmenu = true }, function(event, ...)
				if event == "msg_show" then
					local kind, content = ...
					if kind == "bufwrite" then
						print("**** File saved!")
						-- print("Wrote to " .. content[1][2])
					end
				end
			end)
			-- Toggles
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use Snacks for `:=` command

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>nw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.inlay_hints():map("<leader>uh")
				end,
			})
		end,
	},
}
