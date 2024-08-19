require "nvchad.mappings"

local map = vim.keymap.set

-- splits
map("n", "\\", "<cmd>split<CR>", { desc = "split horizontal" })
map("n", "|", "<cmd>vsplit<CR>", { desc = "split vertical" })
map("n", "<tab>", "<C-w>w", { desc = "split cycle" })

-- buffers
map("n", "B", "<cmd>enew<CR>", { desc = "buffer new" })
map("n", "gb", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

-- tabs
map("n", "T", "<cmd>tabnew<CR>", { desc = "tab new" })
map("n", "gt", "<cmd>tabnext<CR>", { desc = "tab cycle" })
map("n", "X", "<cmd>tabclose<CR>", { desc = "tab close" })
