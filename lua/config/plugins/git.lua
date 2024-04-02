return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufNewFile", "BufReadPre" },
		opts = {},
	},
	{
		"kdheepak/lazygit.nvim",
		event = { "BufNewFile", "BufReadPre" },
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>gg", "<CMD>LazyGit<CR>")
		end,
	},
}
