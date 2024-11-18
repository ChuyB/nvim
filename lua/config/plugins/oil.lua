return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("oil").setup({
			keymaps = {
				["."] = "actions.toggle_hidden",
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>")
	end,
}
