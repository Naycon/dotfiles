return {
  'zbirenbaum/copilot.lua',
  opts = {
    panel = {
      enabled = false,
      -- auto_refresh = false,
      -- keymap = {
      --   jump_prev = "[[",
      --   jump_next = "]]",
      --   accept = "<CR>",
      --   refresh = "gr",
      --   open = "<M-CR>"
      -- },
      -- layout = {
      --   position = "bottom", -- | top | left | right
      --   ratio = 0.4
      -- },
    },
    suggestion = {
      enabled = false,
      -- enabled = true,
      -- auto_trigger = true,
      -- debounce = 75,
      -- keymap = {
      --   accept = "<Tab>",
      --   accept_word = false,
      --   accept_line = false,
      --   next = "<C-n>",
      --   prev = "<C-S-n>",
      --   dismiss = "<C-d>",
      -- },
    },
    -- filetypes = {
    --   yaml = false,
    --   markdown = false,
    --   help = false,
    --   gitcommit = false,
    --   gitrebase = false,
    --   hgcommit = false,
    --   svn = false,
    --   cvs = false,
    --   ["."] = false,
    -- },
    -- copilot_node_command = 'node', -- Node.js version must be > 18.x
    -- server_opts_overrides = {},
  }
}
