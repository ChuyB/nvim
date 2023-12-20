return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup({})
    mason_lspconfig.setup({
      -- List of LSP for mason to install
      ensure_installed = {
        "tsserver",
        "jsonls",
        "html",
        "cssls",
        "hls",
        "jdtls",
        "marksman"
      },
      automatic_installation = true
    })
  end
}

