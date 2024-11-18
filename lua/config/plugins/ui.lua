return {
	{
		"stevearc/dressing.nvim",
		opts = {},
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

			-- Keymaps
			vim.keymap.set("n", "<leader>nh", function()
				noice.cmd("telescope")
			end)
		end,
	},
	{
		"b0o/incline.nvim",
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local devicons = require("nvim-web-devicons")
			require("incline").setup({
				window = {
					placement = {
						vertical = "bottom",
						horizontal = "center",
					},
					padding = 0,
					margin = { vertical = 0, horizontal = 0 },
				},
				hide = {
					cursorline = true,
				},
				render = function(props)
					local function get_git_branch()
						local labels = {}
						local branch = vim.b[props.buf].gitsigns_head
						if branch ~= nil then
							table.insert(labels, { " ", guifg = "#61AfEf" })
							table.insert(labels, { branch, group = "Keyword" })
							table.insert(labels, { " | " })
						end
						return labels
					end

					local function get_git_diff()
						local icons = { removed = "-", changed = "~", added = "+" }
						local signs = vim.b[props.buf].gitsigns_status_dict
						local labels = {}
						if signs == nil then
							return labels
						end
						for name, icon in pairs(icons) do
							if tonumber(signs[name]) and signs[name] > 0 then
								table.insert(labels, { icon .. signs[name] .. " ", group = "Diff" .. name })
							end
						end
						if #labels > 0 then
							table.insert(labels, { "| " })
						end
						return labels
					end

					local function get_diagnostic_label()
						local icons = { error = " ", warn = " ", info = " ", hint = " " }
						local label = {}

						for severity, icon in pairs(icons) do
							local n = #vim.diagnostic.get(
								props.buf,
								{ severity = vim.diagnostic.severity[string.upper(severity)] }
							)
							if n > 0 then
								table.insert(label, { icon .. n .. " ", group = "DiagnosticSign" .. severity })
							end
						end
						if #label > 0 then
							table.insert(label, { "| " })
						end
						return label
					end

					local function get_harpoon_items()
						local harpoon = require("harpoon")
						local marks = harpoon:list().items
						local current_file_path = vim.fn.expand("%:p:.")
						local label = {}

						for id, item in ipairs(marks) do
							if item.value == current_file_path then
								table.insert(label, { id .. " ", guifg = "#FFFFFF", gui = "bold" })
							else
								table.insert(label, { id .. " ", guifg = "#434852" })
							end
						end

						if #label > 0 then
							table.insert(label, 1, { "󰛢 ", guifg = "#61AfEf" })
							table.insert(label, { "| " })
						end
						return label
					end

					local function get_file_name()
						local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
						if filename == "" then
							filename = "[No Name]"
						end
						local ft_icon, ft_color = devicons.get_icon_color(filename)

						local label = {}
						table.insert(label, { (ft_icon or "") .. " ", guifg = ft_color, guibg = "none" })
						table.insert(label, { vim.bo[props.buf].modified and " " or "", guifg = "#d19a66" })
						table.insert(label, { filename, gui = vim.bo[props.buf].modified and "bold,italic" or "bold" })
						if not props.focused then
							label["group"] = "BufferInactive"
						end

						return label
					end

					return {
						{ "", guifg = "#0e0e0e" },
						{
							{ get_git_branch() },
							{ get_diagnostic_label() },
							{ get_git_diff() },
							{ get_harpoon_items() },
							{ get_file_name() },
							guibg = "#0e0e0e",
						},
						{ "", guifg = "#0e0e0e" },
					}
				end,
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		init = function()
			local snacks = require("snacks")
			snacks.setup({
				bigfile = { enabled = true },
				quickfile = { enabled = true },
				statuscolumn = { enabled = true },
				words = { enabled = false },
				gitbrowse = { enabled = true },
				lazygit = { enabled = true },
				notifier = {
					enabled = true,
					timeout = 3000,
				},
				styles = {
					notification = {
						wo = {
							winblend = 0,
							wrap = false,
						},
					},
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>gg", function()
				snacks.lazygit()
			end)
			vim.keymap.set("n", "<leader>nd", function()
				snacks.notifier.hide()
			end)
			vim.keymap.set("n", "<leader>gb", function()
				snacks.gitbrowse()
			end)

			-- Toggles
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						snacks.debug.inspect(...)
					end
					_G.bt = function()
						snacks.debug.backtrace()
					end
					vim.print = _G.dd -- Override print to use snacks for `:=` command

					-- Create some toggle mappings
					snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>nw")
					snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					snacks.toggle.diagnostics():map("<leader>ud")
					snacks.toggle.line_number():map("<leader>ul")
					snacks.toggle.inlay_hints():map("<leader>uh")
				end,
			})

			-- LSP Porgress
			local progress = vim.defaulttable()
			vim.api.nvim_create_autocmd("LspProgress", {
				callback = function(ev)
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
					if not client or type(value) ~= "table" then
						return
					end
					local p = progress[client.id]

					for i = 1, #p + 1 do
						if i == #p + 1 or p[i].token == ev.data.params.token then
							p[i] = {
								token = ev.data.params.token,
								msg = ("[%3d%%] %s%s"):format(
									value.kind == "end" and 100 or value.percentage or 100,
									value.title or "",
									value.message and (" **%s**"):format(value.message) or ""
								),
								done = value.kind == "end",
							}
							break
						end
					end

					local msg = {} ---@type string[]
					progress[client.id] = vim.tbl_filter(function(v)
						return table.insert(msg, v.msg) or not v.done
					end, p)

					local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
					vim.notify(table.concat(msg, "\n"), "info", {
						id = "lsp_progress",
						title = client.name,
						opts = function(notif)
							notif.icon = #progress[client.id] == 0 and " "
								or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
						end,
					})
				end,
			})
		end,
	},
}
