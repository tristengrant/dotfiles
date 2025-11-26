-- Colour Theme: alabaster.nvim - GitHub https://github.com/p00f/alabaster.nvim

return {
  "p00f/alabaster.nvim",
	lazy = false,
	priority = 1000,
	config = function()
    vim.cmd("colorscheme alabaster")
  end,
}
