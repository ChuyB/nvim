return {
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true,
        },
        colors = {
          bg = "#181B20",
        },
        styles = {
          types = "NONE",
          methods = "NONE",
          numbers = "NONE",
          strings = "NONE",
          comments = "italic",
          keywords = "bold",
          constants = "NONE",
          functions = "italic",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "NONE",
        },
      })

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
