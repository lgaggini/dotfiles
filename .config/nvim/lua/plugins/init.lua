return {
  -- conform
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },
  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  -- aerial tagbar
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    keys = {
      { "<leader>tb", "<cmd>AerialToggle<cr>", desc = "aerial toggle" },
    },
    lazy = false
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "v",
          node_incremental = "v",
          scope_incremental = "r",
          node_decremental = "V",
        }
      }
    }
  }
}
