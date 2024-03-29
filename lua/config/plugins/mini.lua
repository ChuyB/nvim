return {
  "https://github.com/echasnovski/mini.nvim",
  config = function()
    local comments = require("mini.comment")
    local pairs = require("mini.pairs")
    local surround = require("mini.surround")
    local hipatterns = require("mini.hipatterns")
    local starter = require("mini.starter")

    pairs.setup()
    surround.setup()
    comments.setup({
      mappings = {
        -- Toggle comment (like `gcip` - comment inner paragraph) for both
        -- Normal and Visual modes
        comment = "gc",
        -- Toggle comment on current line
        comment_line = "gcc",
        -- Toggle comment on visual selection
        comment_visual = "gc",
        -- Define 'comment' textobject (like `dgc` - delete whole comment block)
        textobject = "gc",
      },
    })
    hipatterns.setup({
      highlighters = {
        -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
        fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
        hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
        todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
        note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

        -- Highlight hex color strings (`#rrggbb`) using that color
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    })
    starter.setup({
      content_hooks = {
        starter.gen_hook.adding_bullet(""),
        starter.gen_hook.aligning("center", "center"),
      },
      evaluate_single = true,
      footer = os.date(),
      header = table.concat({
        [[                                                                       ]],
        [[  ██████   █████                   █████   █████  ███                  ]],
        [[ ░░██████ ░░███                   ░░███   ░░███  ░░░                   ]],
        [[  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████   ]],
        [[  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███  ]],
        [[  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███  ]],
        [[  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███  ]],
        [[  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████ ]],
        [[ ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░  ]],
        [[                                                                       ]],
      }, "\n"),
      query_updaters = [[abcdefghilmoqrstuvwxyz0123456789_-,.ABCDEFGHIJKLMOQRSTUVWXYZ]],
      items = {
        { action = "enew",  name = "E: New Buffer",  section = "Builtin actions" },
        { action = "qall!", name = "Q: Quit Neovim", section = "Builtin actions" },
      },
    })
  end,
}
