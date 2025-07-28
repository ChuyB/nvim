return {
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				options = {
					transparency = true,
				},
				styles = {
					types = "bold,italic",
					methods = "NONE",
					numbers = "bold",
					strings = "NONE",
					comments = "italic",
					keywords = "bold",
					constants = "NONE",
					functions = "NONE",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "italic",
					virtual_text = "italic",
				},
			})
			vim.cmd("colorscheme onedark_vivid")
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
		keys = {
			{
				"-",
				function()
					vim.cmd("Oil")
				end,
				desc = "Opens Oil explorer",
			},
		},
	},
	{
		"xzbdmw/colorful-menu.nvim",
		opts = {},
	},
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		opts = {
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = {
					auto_show = true,
					window = { border = "rounded" },
				},
				list = {
					selection = { auto_insert = false },
				},
				menu = {
					border = "rounded",
					draw = {
						-- We don't need label_description now because label and label_description are already
						-- combined together in label by colorful-menu.nvim.
						columns = { { "kind_icon" }, { "label", gap = 1 } },
						components = {
							label = {
								text = function(ctx)
									return require("colorful-menu").blink_components_text(ctx)
								end,
								highlight = function(ctx)
									return require("colorful-menu").blink_components_highlight(ctx)
								end,
							},
						},
					},
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
		keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Add current file to Harpoon",
			},
			{
				"<C-P>",
				function()
					require("harpoon"):list():prev()
				end,
				desc = "Harpoon previous file",
			},

			{
				"<C-N>",
				function()
					require("harpoon"):list():next()
				end,
				desc = "Harpoon next file",
			},
			{
				"<leader>1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Go to Harpoon file 1",
			},
			{
				"<leader>2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Go to Harpoon file 2",
			},
			{
				"<leader>3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Go to Harpoon file 3",
			},
			{
				"<leader>4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Go to Harpoon file 4",
			},
			{
				"<C-e>",
				function()
					local harpoon = require("harpoon")
					local normalize_list = function(t)
						local normalized = {}
						for _, v in pairs(t) do
							if v ~= nil then
								table.insert(normalized, v)
							end
						end
						return normalized
					end
					Snacks.picker({
						finder = function()
							local file_paths = {}
							local list = normalize_list(harpoon:list().items)
							for i, item in ipairs(list) do
								table.insert(file_paths, { text = item.value, file = item.value })
							end
							return file_paths
						end,
						win = {
							input = {
								keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
							},
							list = {
								keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
							},
						},
						actions = {
							harpoon_delete = function(picker, item)
								local to_remove = item or picker:selected()
								harpoon:list():remove({ value = to_remove.text })
								harpoon:list().items = normalize_list(harpoon:list().items)
								picker:find({ refresh = true })
							end,
						},
					})
				end,
				desc = "Toggle telescope harpoon window",
			},
		},
	},
}
