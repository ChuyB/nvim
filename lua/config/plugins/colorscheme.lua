return {
	"olimorris/onedarkpro.nvim",
	priority = 1000, -- Ensure it loads first
	config = function()
		require("onedarkpro").setup({
			options = {
				transparency = true,
			},
			styles = {
				types = "bold",
				methods = "NONE",
				numbers = "bold",
				strings = "NONE",
				comments = "bold,italic",
				keywords = "bold",
				constants = "NONE",
				functions = "NONE",
				operators = "NONE",
				variables = "NONE",
				parameters = "NONE",
				conditionals = "bold",
				virtual_text = "NONE",
			},
		})
		vim.cmd("colorscheme onedark_vivid")
	end,
}
