return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.4",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
		},
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		-- Custom actions inside telescope could go here

		telescope.load_extension("fzf")

		-- Set telescope keymaps
		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")
		keymap.set("n", "<leader>lg", "<cmd>Telescope live_grep<cr>")
		keymap.set("n", "<leader>gg", "<cmd>Telescope grep_string<cr>")
	end,
}
