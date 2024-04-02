vim.opt.nu = true
vim.opt.relativenumber = true

TabLength = 2
vim.opt.tabstop = TabLength
vim.opt.softtabstop = TabLength
vim.opt.shiftwidth = TabLength
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.mouse = ""
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 10
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.signcolumn = "yes"

-- No status lines
vim.opt.laststatus = 0
-- Separation line between horizontal splits
vim.api.nvim_set_hl(0, "Statusline", { link = "Normal" })
vim.api.nvim_set_hl(0, "StatuslineNC", { link = "Normal" })
local str = string.rep("-", vim.api.nvim_win_get_width(0))
vim.opt.statusline = '%#WinSeparator#'..str..'%*'

-- Reduces time for mapings
-- vim.opt.updatetime = 250
-- vim.opt.timeoutlen = 300

-- Preview substitutions live
vim.opt.inccommand = "split"
