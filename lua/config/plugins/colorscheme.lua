return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({})

      vim.cmd("colorscheme onedark_vivid")
    end,
  },
  -- {
  -- 	"catppuccin/nvim",
  -- 	name = "catppuccin",
  -- 	priority = 1000,
  -- 	config = function()
  -- 		require("catppuccin").setup({
  -- 			flavour = "mocha",
  -- 		})
  --
  -- 		vim.cmd("colorscheme catppuccin")
  -- 	end,
  -- },
}
