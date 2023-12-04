return {
  "mfussenegger/nvim-dap",
  name = "nvim-dap",
  config = function()
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter", -- As I'm using mason, this will be in the path
        args = {"${port}"},
      }
    }
    require("dap").adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter", -- As I'm using mason, this will be in the path
        args = {"${port}"},
      }
    }

    for _, language in ipairs({ 'typescript', 'javascript', 'typescriptreact', 'javascriptreact', }) do
      require("dap").configurations[language] = {
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to node",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
        {
          type = 'pwa-chrome',
          name = 'Attach to Chrome, *localhost* tab',
          request = 'attach',
          rootPath = '${workspaceFolder}',
          port = 9222,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          webRoot = '${workspaceFolder}',
          -- Use this to find the right tab to attach to. Without this, the adapter can time out if you have many tabs open.
          urlFilter = '*localhost*',
          -- urlFilter = function() return vim.fn.input('Tab url to debug: ') end,
          -- program = '${file}',
        },
        {
          type = 'pwa-chrome',
          name = 'Attach to Chrome, prompt tab wildcard url',
          request = 'attach',
          rootPath = '${workspaceFolder}',
          port = 9222,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          webRoot = '${workspaceFolder}',
          -- Use this to find the right tab to attach to. Without this, the adapter can time out if you have many tabs open.
          urlFilter = function() return '*' .. vim.fn.input('Tab url to debug: ') .. '*' end,
          -- program = '${file}',
        },
      }
    end

    vim.keymap.set('n', '<leader>ds', require'dap'.continue)
    vim.keymap.set('n', '<leader>dsi', require'dap'.step_into)
    vim.keymap.set('n', '<leader>dsn', require'dap'.step_over)
    vim.keymap.set('n', '<leader>dso', require'dap'.step_out)
    vim.keymap.set('n', '<leader>dt', function()
      require'dap'.disconnect({ restart = false, terminateDebuggee = false })
      require'dap'.close()
      require'dapui'.close({})
    end)
    vim.keymap.set('n', '<leader>db', require'dap'.toggle_breakpoint)
    vim.keymap.set('n', '<Leader>dl', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
  end,
}
