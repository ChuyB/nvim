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

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in CWD" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>lg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in CWD" })
		keymap.set("n", "<leader>gg", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in CWD" })
		keymap.set("n", "<leader>tk", "<cmd>Telescope buffers<cr>")
	end,
}
