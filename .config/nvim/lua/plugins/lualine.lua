return {
  'hoob3rt/lualine.nvim',
  opts = {
    options = {
      theme = 'auto',
      extensions = { 'nvim-tree', 'fzf' },
      component_separators = { '|', '|' },
    },
    sections = {
      lualine_b = {
        {
          'filename',
          file_status = true, -- displays file status (readonly status, modified status)
          path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
        },
      },
      lualine_c = {},
      lualine_x = {
        {
          'diagnostics',
          -- table of diagnostic sources, available sources:
          -- nvim_lsp, coc, ale, vim_lsp
          sources = { 'nvim_lsp' },
          -- displays diagnostics from defined severity
          sections = {'error', 'warn', 'info', 'hint'},
          -- all colors are in format #rrggbb
          color_error = nil, -- changes diagnostic's error foreground color
          color_warn = nil, -- changes diagnostic's warn foreground color
          color_info = nil, -- Changes diagnostic's info foreground color
          color_hint = nil, -- Changes diagnostic's hint foreground color
          symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
        }
      },
      lualine_y = {
        {
          'diff'
        }
      }
    },
  },
}


