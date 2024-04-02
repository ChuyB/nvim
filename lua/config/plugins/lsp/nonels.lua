return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    local lint = null_ls.builtins.diagnostics
    local completion = null_ls.builtins.completion

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.prettierd,
      },
    })

    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
  end,
}
