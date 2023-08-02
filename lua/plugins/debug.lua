return {
  {
    "mfussenegger/nvim-dap",
    config = function(_, opts)
      local ports = {
        ["Answers"] = 9230,
        ["Public API"] = 9201,
        ["Web API"] = 9229,
        ["Worker"] = 9231,
      }

      local typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
          runtimeExecutable = "/Users/charlieplate/.yarn/bin/ts-node",
        },
      }

      local GRAPHITE_DIR = "/Users/charlieplate/Documents/work/graphite" .. ".*"

      if string.match(vim.fn.getcwd(), GRAPHITE_DIR) then
        local sorted_ports = {}
        for k, v in pairs(ports) do
          table.insert(sorted_ports, { k, v })
        end
        table.sort(sorted_ports, function(a, b)
          return a[1] < b[1]
        end)

        for _, port in ipairs(sorted_ports) do
          table.insert(typescript, {
            type = "pwa-node",
            request = "attach",
            port = port[2],
            name = "Attach to " .. port[1],
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            outFiles = { "${workspaceFolder}/dist/**/*.js" },
            webRoot = "${workspaceFolder}/src",
            remoteRoot = "${workspaceFolder}/src",
          })
        end
      end

      require("dap").configurations.typescript = typescript

      require("dap").configurations.vue = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
          runtimeExecutable = "/Users/charlieplate/.yarn/bin/vue-cli-service",
          runtimeArgs = { "serve" },
        },
      }

      local Config = require("lazyvim.config")
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

      for name, sign in pairs(Config.icons.dap) do
        sign = type(sign) == "table" and sign or { sign }
        vim.fn.sign_define(
          "Dap" .. name,
          { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
        )
      end
    end,
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    opts = {
      node_path = "node",
      debugger_path = "/Users/charlieplate/.local/bin/vscode-js-debug",
      -- debugger_cmd = { "chrome-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" }, -- which adapters to register in nvim-dap
    },
    config = function(_, opts)
      require("dap-vscode-js").setup(opts)
    end,
  },
  {
    "David-Kunz/jester",
    opts = {
      cmd = "jest -t '$result' -- $file", -- run command
      identifiers = { "test", "it" }, -- used to identify tests
      prepend = { "describe" }, -- prepend describe blocks
      expressions = { "call_expression" }, -- tree-sitter object used to scan for tests/describe blocks
      path_to_jest_run = "jest", -- used to run tests
      path_to_jest_debug = "/Users/charlieplate/.yarn/bin/jest", -- used for debugging
      terminal_cmd = ":vsplit | terminal", -- used to spawn a terminal for running tests, for debugging refer to nvim-dap's config
      dap = { -- debug adapter configuration
        type = "pwa-node",
        request = "launch",
        port = 9231,
        name = "Jest",
        sourceMaps = true,
        protocol = "inspector",
        runtimeArgs = { "--inspect-brk", "$path_to_jest", "--no-coverage", "-t", "$result", "--", "$file" },
        console = "integratedTerminal",
        outFiles = { "${workspaceFolder}/dist/**/*.js" },
        webRoot = "${workspaceFolder}/src",
        remoteRoot = "${workspaceFolder}/src",
      },
    },
    config = function(_, opts)
      require("jester").setup(opts)
    end,
    filetypes = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
    keys = {
      { "<leader>t", desc = "Test" },
      { "<leader>dtd", "<cmd>lua require'jester'.debug()<cr>", desc = "Debug test" },
      { "<leader>dtr", "<cmd>lua require'jester'.run()<cr>", desc = "Run test" },
      { "<leader>dtf", "<cmd>lua require'jester'.run_file()<cr>", desc = "Run file" },
      { "<leader>dtD", "<cmd>lua require'jester'.debug_last()<cr>", desc = "Debug last" },
      { "<leader>dtR", "<cmd>lua require'jester'.run_last()<cr>", desc = "Run last" },
    },
  },
}
