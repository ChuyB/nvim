return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    local formatting = null_ls.builtins.formatting
    local lint = null_ls.builtins.diagnostics
    local completion = null_ls.builtins.completion

    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        formatting.stylua,
        formatting.prettier,
        formatting.black,
      },

      -- Format on Save
      -- on_attach = function(client, bufnr)
      -- 	if client.supports_method("textDocument/formatting") then
      -- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      -- 		vim.api.nvim_create_autocmd("BufWritePre", {
      -- 			group = augroup,
      -- 			buffer = bufnr,
      -- 			callback = function()
      -- 				vim.lsp.buf.format({ async = false })
      -- 			end,
      -- 		})
      -- 	end
      -- end,
    })

    vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, {})
  end,
}
