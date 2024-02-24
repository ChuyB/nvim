return {
  "navarasu/onedark.nvim",
  lazy = false,
  priority = 1000, -- Ensure it loads first
  config = function()
    require("onedark").setup({
      style = "dark",
    })

    vim.cmd("colorscheme onedark")
  end,
}
