vim.cmd([[
  augroup _general_settings
    autocmd!
		autocmd BufWinEnter * :set endofline
  augroup end
  ]])
