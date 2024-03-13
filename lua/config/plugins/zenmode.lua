return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      options = {
        signcolumn = "no", -- disable signcolumn
      },
      width = 90,
    },

    plugins = {
      wezterm = {
        enabled = true,
        -- can be either an absolute font size or the number of incremental steps
        font = "+0.3", -- (10% increase per step)
      },
      -- tmux = {
      --   enabled = true
      -- },
      twilight = { enabled = false }
    }
  }
}
