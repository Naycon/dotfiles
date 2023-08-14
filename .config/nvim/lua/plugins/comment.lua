return {
  'numToStr/Comment.nvim',
  lazy = false,
  opts = {
    toggler = {
    },
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = '<NOP>',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = '<NOP>',
    },
    mappings = {
      basic = true,
      extra = false,
    }
  },
}

