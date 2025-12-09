return {
  { 
    'nyoom-engineering/oxocarbon.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      -- Apply the background overrides after the colorscheme loads
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    end,
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
      background = "dark"
    },
  }
}
