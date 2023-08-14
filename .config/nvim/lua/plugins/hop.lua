return {
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    -- require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    require'hop'.setup()

    vim.keymap.set('', '<Leader>j', '<cmd>HopLineAC<CR>', {})
    vim.keymap.set('', '<Leader>k', '<cmd>HopLineBC<CR>', {})
    vim.keymap.set('', '<Leader>w', '<cmd>HopWord<CR>', {})
    vim.keymap.set('', '<Leader>f', '<cmd>HopChar1<CR>', {})
    vim.keymap.set('', 's', '<cmd>HopChar2<CR>', {})
  end
}
