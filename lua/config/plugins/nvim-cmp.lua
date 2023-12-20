return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- For text in buffer
    "hrsh7th/cmp-path", -- For file system paths
    "L3MON4D3/LuaSnip", -- Snippet engine
    "rafamadriz/friendly-snippets", -- Snippets for different languages
    "saadparwaiz1/cmp_luasnip", -- Completion for snippets
    "onsails/lspkind.nvim" -- VSCode like icons
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noinsert",
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<S-Tab>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<Tab>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-p>"] = cmp.mapping.scroll_docs(-4),
      ["<C-n>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = "nvim_lsp" }, -- lsp completion
      { name = "path" }, -- file system paths
      { name = "luasnip" }, -- snippets
      { name = "buffer" }, -- text within current buffer
    }),

    -- configure lspkind for vs-code like pictograms in completion menu
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
  })
  end
}
