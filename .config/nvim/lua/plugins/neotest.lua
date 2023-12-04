return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "haydenmeade/neotest-jest",
  },
  config = function()
    require'neotest'.setup({
      adapters = {
        require('neotest-jest')({
          jestCommand = "yarn test --watch ",
          -- jestCommand = "yarn test --",
          -- jestConfigFile = "custom.jest.config.ts",
          env = { CI = true },
          cwd = function(path)
            return vim.fn.getcwd()
          end,
        }),
      },
    })

    vim.keymap.set('n', '<leader>ts', require 'neotest'.summary.toggle)
    vim.keymap.set('n', '<leader>tt', require 'neotest'.run.stop)
    vim.keymap.set('n', '<leader>to', require 'neotest'.output_panel.toggle)
    vim.keymap.set('n', '<leader>trs', require 'neotest'.run.run)
    vim.keymap.set('n', '<leader>trf', function() require 'neotest'.run.run(vim.fn.expand("%")) end)
  end,
}
