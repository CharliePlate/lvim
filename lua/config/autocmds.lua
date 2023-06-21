vim.cmd([[
  augroup _general_settings
    autocmd!
		autocmd BufWritePre * :set endofline
  augroup end
  ]])
