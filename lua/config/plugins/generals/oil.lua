return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {},
  lazy = false,
	keys = {
		{
			"-",
			function()
				vim.cmd("Oil")
			end,
			desc = "Opens Oil explorer",
		},
	},
}
