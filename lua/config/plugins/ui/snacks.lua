return {
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
}
