-- Telescope - Find, filter, preview, pick.
-- GitHub - https://github.com/nvim-telescope/telescope.nvim

return {
  {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    version = "*",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
}
