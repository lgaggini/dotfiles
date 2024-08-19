require "nvchad.options"

-- folding by treesitter
local o = vim.o
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
