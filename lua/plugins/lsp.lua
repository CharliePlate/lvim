return {
  -- NOTE: Copilot
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    opts = vim.tbl_deep_extend("force", require("lazyvim.plugins.extras.coding.copilot"), {
      suggestion = {
        enabled = true,
        auto_trigger = false,
        debounce = 75,
        keymap = {
          accept = "jl",
          next = "jj",
          prev = "<M-H>",
          dismiss = "<C-]>",
        },
      },
      copilot_node_command = "/Users/charlieplate/.nvm/versions/node/v16.18.1/bin/node",
    }),
    config = function(_, opts)
      vim.defer_fn(function()
        require("copilot").setup(opts)
      end, 100)
    end,
  },
  -- NOTE: LspConfig
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        format = {
          formatting_options = nil,
          timeout_ms = 5000,
        },
        servers = {
          jsonls = require("../config/lsp/jsonls"),
          cssls = require("../config/lsp/cssls"),
        },
        capabilities = {
          textDocument = {
            foldingRange = {
              dynamicRegistration = false,
              lineFoldingOnly = true,
            },
          },
        },
        inlay_hints = {
          enabled = true,
        },
      })
    end,
  },
  -- NOTE: Inc Rename
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      return vim.tbl_deep_extend("force", opts, {
        sources = vim.list_extend(opts.sources, {
          nls.builtins.formatting.gofumpt.with({
            filetypes = { "go" },
          }),
          nls.builtins.formatting.prettierd.with({
            filetypes = { "javascript", "typescript", "json", "css", "scss", "html", "yaml", "markdown", "svelte" },
          }),
        }),
      })
    end,
  },
}
