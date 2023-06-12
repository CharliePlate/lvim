return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    opts = {
      enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
      max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
      trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
      patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        default = {
          "class",
          "function",
          "method",
          "for",
          "while",
          "if",
          "try",
          -- 'switch',
          -- 'case',
        },
      },
      zindex = 20, -- The Z-index of the context window
      mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
      separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, {
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "css" }, -- list of language that will be disabled
        },
        autopairs = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        indent = { enable = false, disable = { "python", "css" } },
        -- yati = {
        --   enable = true,
        --   disable = { "python" },
        --   default_lazy = true,
        --   -- Determine the fallback method used when we cannot calculate indent by tree-sitter
        --   --   "auto": fallback to vim auto indent
        --   --   "asis": use current indent as-is
        --   --   "cindent": see `:h cindent()`
        --   -- Or a custom function return the final indent result.
        --   default_fallback = "auto",
        -- },
        rainbow = {
          enable = true,
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]a"] = "@parameter.outer",
              ["]l"] = "@loop.outer",
              ["]i"] = "@conditional.outer",
              ["]f"] = "@function.outer",
            },
            goto_next_end = {
              ["]A"] = "@parameter.outer",
              ["]L"] = "@loop.outer",
              ["]I"] = "@conditional.outer",
              ["]F"] = "@function.outer",
            },
            goto_previous_start = {
              ["[a"] = "@parameter.outer",
              ["[l"] = "@loop.outer",
              ["[i"] = "@conditional.outer",
              ["[f"] = "@function.outer",
            },
            goto_previous_end = {
              ["[A"] = "@parameter.outer",
              ["[L"] = "@loop.outer",
              ["[I"] = "@conditional.outer",
              ["[F"] = "@function.outer",
            },
          },
        },
      })
    end,
  },
}
