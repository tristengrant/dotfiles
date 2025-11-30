-- Colour Theme: kanagawa.nvim - https://github.com/rebelot/kanagawa.nvim
-- Colour Theme: miikanissi/modus-themes.nvim - https://github.com/miikanissi/modus-themes.nvim
-- Colour Theme: rose-pine/neovim - https://github.com/rose-pine/neovim
-- Colour Theme: xeind/nightingale.nvim - https://github.com/xeind/nightingale.nvim
-- Colour Theme: Skardyy/makurai-nvim - https://github.com/Skardyy/makurai-nvim
-- Current Colour Theme: vague-theme/vague.nvim - https://github.com/vague-theme/vague.nvim
-- Colour Theme: mistweaverco/retro-theme.nvim - https://github.com/mistweaverco/retro-theme.nvim

return {
  -- "rebelot/kanagawa.nvim",
  -- "miikanissi/modus-themes.nvim",
  -- "rose-pine/neovim",
  -- "folke/tokyonight.nvim",
  -- "xeind/nightingale.nvim",
  -- "Skardyy/makurai-nvim",
  "vague-theme/vague.nvim",
  -- "mistweaverco/retro-theme.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('vague').setup({
      style = "auto",
      transparent = false,
    })

    vim.cmd("colorscheme vague")
  end,
}
