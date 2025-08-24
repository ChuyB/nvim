return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {},
	keys = {
		{
			"<leader>a",
			function()
				require("harpoon"):list():add()
			end,
			desc = "Add current file to Harpoon",
		},
		{
			"<C-P>",
			function()
				require("harpoon"):list():prev()
			end,
			desc = "Harpoon previous file",
		},

		{
			"<C-N>",
			function()
				require("harpoon"):list():next()
			end,
			desc = "Harpoon next file",
		},
		{
			"<leader>1",
			function()
				require("harpoon"):list():select(1)
			end,
			desc = "Go to Harpoon file 1",
		},
		{
			"<leader>2",
			function()
				require("harpoon"):list():select(2)
			end,
			desc = "Go to Harpoon file 2",
		},
		{
			"<leader>3",
			function()
				require("harpoon"):list():select(3)
			end,
			desc = "Go to Harpoon file 3",
		},
		{
			"<leader>4",
			function()
				require("harpoon"):list():select(4)
			end,
			desc = "Go to Harpoon file 4",
		},
		{
			"<C-e>",
			function()
				local harpoon = require("harpoon")
				local normalize_list = function(t)
					local normalized = {}
					for _, v in pairs(t) do
						if v ~= nil then
							table.insert(normalized, v)
						end
					end
					return normalized
				end
				Snacks.picker({
					finder = function()
						local file_paths = {}
						local list = normalize_list(harpoon:list().items)
						for i, item in ipairs(list) do
							table.insert(file_paths, { text = item.value, file = item.value })
						end
						return file_paths
					end,
					win = {
						input = {
							keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
						},
						list = {
							keys = { ["dd"] = { "harpoon_delete", mode = { "n", "x" } } },
						},
					},
					actions = {
						harpoon_delete = function(picker, item)
							local to_remove = item or picker:selected()
							harpoon:list():remove({ value = to_remove.text })
							harpoon:list().items = normalize_list(harpoon:list().items)
							picker:find({ refresh = true })
						end,
					},
				})
			end,
			desc = "Toggle telescope harpoon window",
		},
	},
}
