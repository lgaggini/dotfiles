require "nvchad.mappings"

local map = vim.keymap.set

-- command line
map("c", "<C-a>", "<Home>", {desc = "start of command line"})
map("c", "<C-e>", "<End>", {desc = "end of command line"})
map("c", "<C-p>", "<Up>", {desc = "previous command"})
map("c", "<C-n>", "<Down>", {desc = "next command"})
map("c", "<C-b>", "<Left>", {desc = "previous char"})
map("c", "<C-f>", "<Right>", {desc = "next char"})
map("c", "<M-b>", "<S-Left>", {desc = "previous word"})
map("c", "<M-f>", "<S-Right>", {desc = "next word"})

-- splits
map("n", "\\", "<cmd>split<CR>", { desc = "split horizontal" })
map("n", "|", "<cmd>vsplit<CR>", { desc = "split vertical" })
map("n", "<tab>", "<C-w>w", { desc = "split cycle" })

-- buffers
map("n", "B", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "gb", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })
map("n", "gB", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

-- tabs
map("n", "T", "<cmd>tabnew<CR>", { desc = "tab new" })
map("n", "gt", "<cmd>tabnext<CR>", { desc = "tab next" })
map("n", "gT", "<cmd>tabprev<CR>", { desc = "tab prev" })
map("n", "X", "<cmd>tabclose<CR>", { desc = "tab close" })
