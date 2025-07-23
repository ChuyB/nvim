return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build =
      "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release && cmake --install build --prefix build",
    },
  },
  config = function()
    local telescope = require("telescope")

    telescope.setup({
      defaults = {
        prompt_prefix = "󰍉 ",
        selection_caret = " ",
        entry_prefix = "  ",
        multi_icon = "<>",
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")
    telescope.load_extension("refactoring")
    telescope.load_extension("flutter")

    -- Set telescope keymaps
    local keymap = vim.keymap
    local builtin = require("telescope.builtin")

    keymap.set("n", "<leader>ff", builtin.find_files)
    keymap.set("n", "<leader>bf", builtin.buffers)
    keymap.set("n", "<leader>fr", builtin.oldfiles)
    keymap.set("n", "<leader>lg", builtin.live_grep)
    keymap.set("n", "<leader>sg", builtin.grep_string)
    keymap.set("n", "<leader>rr", function() telescope.extensions.refactoring.refactors() end)
    keymap.set("n", "<leader>ft", function() telescope.extensions.flutter.commands() end)
    keymap.set("n", "<leader>/", "<CMD>Telescope find_files theme=dropdown previewer=false<CR>")
  end,
}
