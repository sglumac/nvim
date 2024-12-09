
return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
      })
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require('dap')

      -- Set up codelldb Debug Adapter
      dap.adapters.codelldb = {
        type = 'server',
        port = "${port}",
        executable = {
          command = vim.fn.stdpath('data') .. '/mason/bin/codelldb', -- Ensure this is the correct path to codelldb installed by Mason
          args = { "--port", "${port}" },
        }
      }

      -- Debug Configuration for C++ and C files
      dap.configurations.cpp = {
        {
          name = 'Launch C++ Program',
          type = 'codelldb',        -- Matches the adapter name defined above
          request = 'launch',       -- Launch mode
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',  -- Current directory where the program will run
          stopOnEntry = false,         -- Whether to stop at the entry point of the program
          args = {},                   -- Command-line arguments to the program
          runInTerminal = false,
        },
      }

      -- Reuse the same configuration for C files
      dap.configurations.c = dap.configurations.cpp

      -- Key Mappings for Debug Actions
      local keymap = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Set a breakpoint
      keymap('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<CR>', opts)

      -- Start or continue debugging
      keymap('n', '<leader>dr', ':lua require("dap").continue()<CR>', opts)

      -- Stop debugging and close DAP UI
      keymap('n', '<leader>dq', ':lua require("dap").terminate()<CR>:lua require("dapui").close()<CR>', opts)

      -- Step over a function
      keymap('n', '<leader>dn', ':lua require("dap").step_over()<CR>', opts)

      -- Step into a function
      keymap('n', '<leader>ds', ':lua require("dap").step_into()<CR>', opts)

      -- Step out of a function
      keymap('n', '<leader>do', ':lua require("dap").step_out()<CR>', opts)

      -- Open or close the DAP UI
      keymap('n', '<leader>du', ':lua require("dapui").toggle()<CR>', opts)
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()
      local dap = require('dap')
      local dapui = require('dapui')

      -- Automatically open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}

