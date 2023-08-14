return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = { "css", "dart", "dockerfile", "html", "java", "javascript", "jsdoc", "json", "lua", "python", "scss", "tsx", "typescript", "vim", "yaml" }, -- "all" or a list of languages
        ignore_install = { "vala", "latex" }, -- List of parsers to ignore installing
        highlight = {
          enable = true,              -- false will disable the whole extension
          disable = { "c", "rust", "vala", "latex" },  -- list of language that will be disabled
          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        sync_install = false,
        indent = { enable = true },
      })
    end,
}

