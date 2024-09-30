vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Set the filetype for *.g files to 'antlr3'
vim.api.nvim_exec([[
  augroup antlrFileType
    autocmd!
    autocmd BufRead,BufNewFile *.g set filetype=antlr3
  augroup END
]], false)

-- Set the filetype for *.g4 files to 'antlr4'
vim.api.nvim_exec([[
  augroup antlr4FileType
    autocmd!
    autocmd BufRead,BufNewFile *.g4 set filetype=antlr4
  augroup END
]], false)
