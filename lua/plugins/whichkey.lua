local setup = {
  plugins = {
    marks = false,
    registers = false,
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
    spelling = { enabled = true, suggestions = 20 },
  },
  popup_mappings = {
    scroll_down = "<c-d>",
    scroll_up = "<c-u>",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
    winblend = 0,
  },
}

local mappings = {
  ["<Tab>"] = { name = "Tab" },
  q = { name = "Quit" },
  w = { name = "Window" },
  f = { name = "File" },
  c = { name = "Code" },
  u = { name = "UI" },
  b = { name = "Buffer" },
  x = { name = "Trouble" },
  e = { "<cmd>Neotree<CR>", "Explorer" },
  L = { "<cmd>Lazy<CR>", "Lazy" },
  g = {
    name = "Git",
    g = { "<cmd>LazyGit<cr>", "Lazygit" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", "Undo Stage Hunk" },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Copilot panel<cr>", "Copilot" },
    C = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = { "<cmd>DiffviewOpen<cr>", "Open Diff" },
    D = { "<cmd>DiffviewClose<cr>", "Close Diff" },
    h = { "<cmd>DiffviewFileHistory %<cr>", "File History" },
  },
  l = {
    name = "LSP",
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>Mason<cr>", "Mason Info" },
    j = { vim.diagnostic.goto_next, "Next Diagnostic" },
    k = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
    l = { vim.lsp.codelens.run, "CodeLens Action" },
    q = { vim.diagnostic.setloclist, "Quickfix" },
    r = { ":IncRename " .. vim.fn.expand("<cword>"), "Rename" },
    s = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
    e = { "<cmd>Telescope quickfix<cr>", "Telescope Quickfix" },
  },

  s = {
    name = "Search",
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    B = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
    H = { "<cmd>Telescope highlights<cr>", "Find highlight groups" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
    t = { "<cmd>Telescope live_grep<cr>", "Text" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    p = {
      "<cmd>lua require('telescope.builtin').colorscheme({enable_preview = true})<cr>",
      "Colorscheme with Preview",
    },
    o = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
  },
  d = {
    name = "Debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
    o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
    O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
    l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
    u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
    x = { "<cmd>lua require'dap'.terminate()<cr><cmd>lua require'dapui'.close()<cr>", "Exit" },
    k = { "<cmd>lua require('dapui').eval() <cr>", "Eval" },
    K = { "<cmd>lua require('dapui').eval()<cr><cmd>lua require('dapui').eval()<cr>", "Eval and Enter Hover" },
  },
}

local vmappings = {
  ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comment toggle linewise (visual)" },
  d = {
    name = "Debug",

    t = { "<cmd>lua require('packages.functions').visual_selection()<cr>", "test" },
    k = { "<cmd>lua require('dapui').eval()<cr>", "Eval" },
    K = { "<cmd>lua require('dapui').eval()<cr><cmd>lua require('dapui').eval()<cr>", "Eval and Enter Hover" },
  },
}

local normal_opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local visual_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
}

return {
  "folke/which-key.nvim",
  opts = {
    setup = setup,
    mappings = mappings,
    vmappings = vmappings,
    normal_opts = normal_opts,
    visual_opts = visual_opts,
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts.setup)
    wk.register(opts.mappings, opts.normal_opts)
    wk.register(opts.vmappings, opts.visual_opts)
  end,
}
