return {
	"mfussenegger/nvim-lint",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local linter = require("lint")

		linter.linters_by_ft = {}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				linter.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>lt", function()
			linter.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
