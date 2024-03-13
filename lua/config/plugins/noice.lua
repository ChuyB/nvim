return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config = function()
		local noice = require("noice")
		local notify = require("notify")
		noice.setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},

			function(_, opts)
				table.insert(opts.routes, {
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = { skip = true },
				})
				local focused = true
				vim.api.nvim_create_autocmd("FocusGained", {
					callback = function()
						focused = true
					end,
				})
				vim.api.nvim_create_autocmd("FocusLost", {
					callback = function()
						focused = false
					end,
				})
				table.insert(opts.routes, 1, {
					filter = {
						cond = function()
							return not focused
						end,
					},
					view = "notify_send",
					opts = { stop = false },
				})

				opts.commands = {
					all = {
						-- options for the message history that you get with `:Noice`
						view = "split",
						opts = { enter = true, format = "details" },
						filter = {},
					},
				}

				opts.presets.lsp_doc_border = true
			end,
		})
		notify.setup({
			background_colour = "#000000",
			timeout = 5000,
			render = "wrapped-compact",
		})
		vim.keymap.set("n", "<leader>nh", function()
			require("noice").cmd("history")
		end)
		vim.keymap.set("n", "<leader>nd", function()
			require("noice").cmd("dismiss")
		end)
	end,
}
