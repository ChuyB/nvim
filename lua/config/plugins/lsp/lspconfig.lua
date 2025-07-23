local lsp_list = {
  "lua_ls",
  "ts_ls",
  "emmet_language_server",
  "tailwindcss",
  "jdtls",
  "pylsp",
  "clangd",
  "cssls",
  "gopls",
}

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")
      -- Completion
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- LSP settings (for overriding per client)
      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
      }

      -- SERVERS --
      lspconfig.ts_ls.setup({
        handlers = handlers,
        capabilities = capabilities,
      })
      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.gopls.setup({
        capabilities = capabilities,
        handlers = handlers,
      })
      lspconfig.pylsp.setup({
        capabilities = capabilities,
        handlers = handlers,
        settings = {
          configurationSources = { "flake8" },
          pylsp = {
            plugins = {
              pyflakes = { enabled = true },
              pycodestyle = {
                enable = false,
                ignore = { "E501", "E231", "E261", "E302", "E251", "E722", "E202", "W293", "W291" },
              },
            },
          },
        },
      })
      lspconfig.jdtls.setup({
        capabilities = capabilities,
        handlers = {
          ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
          ["textDocument/signatureHelp"] = vim.lsp.with(
            vim.lsp.handlers.signature_help,
            { border = "rounded" }
          ),
          ["$/progress"] = function(_, result, ctx) end,
        },
      })
      lspconfig.lua_ls.setup({
        handlers = handlers,
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = false,
        float = { border = "rounded" },
      })

      local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      -- On Attach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
          vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
          vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
          vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR", opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)
        end,
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = lsp_list,
    },
  },
}
