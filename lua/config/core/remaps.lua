vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>w", "<cmd>w!<cr>")
keymap.set("n", "<leader>q", "<cmd>q!<cr>")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "<C-d>", "<C-d>zz")
