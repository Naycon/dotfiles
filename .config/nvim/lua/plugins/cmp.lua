return {
  'hrsh7th/nvim-cmp',
  lazy = false,
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'dcampos/nvim-snippy',
    'dcampos/cmp-snippy',
    'zbirenbaum/copilot-cmp',
  },
  config = function()
    local cmp = require'cmp'
    local has_words_before = function()
      if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line-1, 0, line-1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup({
      snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
          require('snippy').expand_snippet(args.body) -- For `snippy` users.
        end,
      },
      window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
      },
      mapping = cmp.mapping.preset.insert({
        -- Fix tab not indenting text
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() or has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end),
        -- ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      }),
      experimental = {
        ghost_text = true -- NOTE: this feature conflicts with copilot.vim's preview. Turn off if using that plugin!
      },
      sources = cmp.config.sources({
        { name = "copilot", group_index = 2 },
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'snippy' }, -- For snippy users.
      }, {
        { name = 'buffer' },
      })
    })

    -- Turn off copilot suggestions when cmp menu is open.
    cmp.event:on("menu_opened", function()
      vim.b.copilot_suggestion_hidden = true
    end)

    cmp.event:on("menu_closed", function()
      vim.b.copilot_suggestion_hidden = false
    end)
  end,
}
