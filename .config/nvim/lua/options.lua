require "nvchad.options"

local o = vim.o
-- folding by treesitter
o.foldmethod = 'expr'
o.foldexpr = 'nvim_treesitter#foldexpr()'
-- system clipboard
o.clipboard = 'unnamed'
-- show hidden chars
o.list = true
-- expand tab
o.expandtab = true
-- gui configs
if vim.g.neovide then
  o.guifont = "Hack Nerd Font Mono:h16"
  vim.g.neovide_opacity = 0.75
end
