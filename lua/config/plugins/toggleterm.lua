return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")

    toggleterm.setup({
      size = 50,
      insert_mappings = true,
      start_in_insert = true,
      float_opts = {
        border = "curved",
        width = 100,
        height = 25
      },
      shell = "pwsh.exe --nologo"
    })

    vim.keymap.set({ "n", "t" }, "<C-n><C-f>", "<cmd>ToggleTerm direction=float<cr>")
    vim.keymap.set({ "n", "t" }, "<C-n><C-s>", "<cmd>ToggleTerm direction=vertical<cr>")
  end
}

