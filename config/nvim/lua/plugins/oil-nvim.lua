-- Oil.nvim - File explorer: Edit your filesystem like a buffer
-- GitHub - https://github.com/stevearc/oil.nvim

return {
  {
    "stevearc/oil.nvim",
    version = "*",
    opts = {},
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional
      {
        "nvim-mini/mini.icons",       -- optional
        opts = {},                    -- mini.icons needs setup
      },
    },
    lazy = false,
  },
}
