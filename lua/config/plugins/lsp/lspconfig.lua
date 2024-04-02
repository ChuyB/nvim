local lsp_list = {
	"lua_ls",
	"tsserver",
	"emmet_language_server",
	"tailwindcss",
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
			lspconfig.tsserver.setup({
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
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		opts = {
			ensure_installed = lsp_list,
		},
	},
}