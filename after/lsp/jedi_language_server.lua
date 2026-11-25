-- Lightweight Python LSP: hover, definition, references, completion. No linting/type-checking noise.
return {
	cmd = { "jedi-language-server" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
}
