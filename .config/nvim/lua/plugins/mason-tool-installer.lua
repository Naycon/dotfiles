return {
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  name = 'mason-tool-installer',
  opts = {

    -- a list of all tools you want to ensure are installed upon
    -- start; they should be the names Mason uses for each tool
    ensure_installed = {
      'prettierd',
    },
  },
  dependencies = {
    'mason',
  }
}
