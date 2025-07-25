local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

plugins = {{import = "config.plugins"}, {import = "config.plugins.lsp"}}
opts = {
  checker = {
    enabled = false,
    -- notify = false
  },
  change_detection = {
    notify = false
  }
}
require("lazy").setup(plugins, opts)

