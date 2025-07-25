return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	root_dir = vim.fs.dirname(vim.fs.find({ ".git" }, { upward = true })[1]),
	filetypes = { "javascriptreact", "javascript.jsx", "typescriptreact", "typescript.tsx", "html" },
}
