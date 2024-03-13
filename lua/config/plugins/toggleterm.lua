return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      local toggleterm = require("toggleterm")

      local powershell_options = {
        shell = "pwsh.exe -nologo",
        shellcmdflag =
        "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
      }

      for option, value in pairs(powershell_options) do
        vim.opt[option] = value
      end

      toggleterm.setup({})

      vim.keymap.set({ "n", "t" }, "<leader>vt", "<cmd>ToggleTerm size=60 direction=vertical<cr>", {})
      vim.keymap.set({ "n", "t" }, "<leader>ft", "<cmd>ToggleTerm direction=float<cr>", {})
    end,
  },
}

