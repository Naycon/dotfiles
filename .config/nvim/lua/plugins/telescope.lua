return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    local center_dropdown = {
      path_display = { "smart" },
      theme = "dropdown",
      layout_config = {
        center = {
          width = 120,
        },
      },
    }
    local cursor = {
      layout_strategy = "cursor",
      sorting_strategy = "ascending",
      layout_config = {
        cursor = {
          width = 60,
          height = 8,
        }
      }
    }
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        path_display = function(opts, path)
          local tail = require("telescope.utils").path_tail(path)
          local smartPath = require("telescope.utils").path_smart(path)
          return string.format("%s (%s)", tail, smartPath)
        end,
      },
      pickers = {
        lsp_references = center_dropdown,
        lsp_definitions = vim.tbl_extend("error", center_dropdown, {
          jump_type = "never",
        }),
        lsp_document_diagnostics = center_dropdown,
        lsp_document_symbols = center_dropdown,
        lsp_dynamic_workspace_symbols = center_dropdown,
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_cursor {
            -- even more opts
          }

          -- pseudo code / specification for writing custom displays, like the one
          -- for "codeactions"
          -- specific_opts = {
            --   [kind] = {
              --     make_indexed = function(items) -> indexed_items, width,
              --     make_displayer = function(widths) -> displayer
              --     make_display = function(displayer) -> function(e)
              --     make_ordinal = function(e) -> string
            --   },
            --   -- for example to disable the custom builtin "codeactions" display
            --      do the following
            --   codeactions = false,
          -- }
        }
      }
    })
    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<C-p>', builtin.find_files, { silent = true })
    vim.keymap.set('n', 'gb', builtin.buffers, {})
    -- gc to see command history
    vim.keymap.set('n', 'gc', builtin.command_history, {})
    -- ctrl + g to search all files with Telescope
    -- vim.keymap.set('n', '<C-g>', ':Telescope grep_string search=', {})
    vim.keymap.set('n', '<C-g>', function()
      local user_input = vim.fn.input("Search string: ")
      local hist_cmd = 'lua require("telescope.builtin").grep_string({search="' .. user_input .. '"})'


      vim.fn.histadd("cmd", hist_cmd)

      builtin.grep_string({ search = user_input })
      -- local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      -- vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { "_{" .. user_input .. "}" })
    end)
    -- ctrl + f to live search all files with Telescope
    vim.keymap.set('n', '<C-f>', builtin.current_buffer_fuzzy_find, {})
    vim.keymap.set('n', '<C-a>', builtin.live_grep, {})
    -- space + g to search word under cursor in all files with Telescope
    vim.keymap.set('n', '<Leader>g', builtin.grep_string, {})

    -- search selected visually selected string
    _G.johan = _G.johan or {
      search_selected = {}
    }
    _G.johan.search_selected = function()
      local s_start = vim.fn.getpos("'<")
      local s_end = vim.fn.getpos("'>")
      local n_lines = math.abs(s_end[2] - s_start[2]) + 1
      local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
      lines[1] = string.sub(lines[1], s_start[3], -1)
      if n_lines == 1 then
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
      else
        lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
      end
      local selected_text = table.concat(lines, '\n')
      return builtin.grep_string({ search = selected_text })
    end
    vim.keymap.set('x', '<Leader>g', ':<C-u>call v:lua.johan.search_selected()<CR>',  {})

    -- -- Preview definition
    vim.keymap.set('n', 'gd', builtin.lsp_definitions, { silent = true })
    -- -- Preview references
    vim.keymap.set('n', 'gr', builtin.lsp_references, { silent = true })
    -- -- Code actions under cursor
    -- :nnoremap <silent><leader>ca <cmd>Telescope lsp_code_actions<CR>
    -- :vnoremap <silent><leader>ca :<C-U>Telescope lsp_range_code_actions<CR>
    -- -- Show diagnostics
    -- vim.keymap.set('n', '<leader>cd', builtin.lsp_document_diagnostics, { silent = true })
    -- -- Document symbols
    -- vim.keymap.set('n', 'gs', builtin.lsp_document_symbols, { silent = true })
    -- -- Workspace symbols
    vim.keymap.set('n', 'gws', builtin.lsp_dynamic_workspace_symbols, { silent = true })

  end,
}
