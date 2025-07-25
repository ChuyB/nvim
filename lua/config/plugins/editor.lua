return {
  -- {
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   config = function ()
  --     vim.cmd("colorscheme cyberdream")
  --   end
  -- },
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				options = {
					transparency = true,
				},
				styles = {
					types = "NONE",
					methods = "NONE",
					numbers = "NONE",
					strings = "NONE",
					comments = "italic",
					keywords = "bold",
					constants = "NONE",
					functions = "italic",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "italic",
					virtual_text = "NONE",
				},
			})
			vim.cmd("colorscheme onedark_dark")
		end,
	},
	{
		"stevearc/oil.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			keymap = {
				["."] = "actions.toggle_hidden",
			},
		},
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
}
