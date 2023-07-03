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
          -- vtsls = require("../config/lsp/vtsls"),
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
  -- NOTE: VTSLS
  {
    "yioneko/nvim-vtsls",
  },
  -- NOTE: Inlay Hints
  -- {
  --   "lvimuser/lsp-inlayhints.nvim",
  --   event = "LspAttach",
  --   branch = "anticonceal",
  --   opts = {},
  --   init = function()
  --     vim.api.nvim_create_autocmd("LspAttach", {
  --       group = vim.api.nvim_create_augroup("LspAttach_inlayhints", {}),
  --       callback = function(args)
  --         if not (args.data and args.data.client_id) then
  --           return
  --         end
  --         local client = vim.lsp.get_client_by_id(args.data.client_id)
  --         require("lsp-inlayhints").on_attach(client, args.buf, false)
  --       end,
  --     })
  --   end,
  -- },
  -- NOTE: Inc Rename
  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
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
}
