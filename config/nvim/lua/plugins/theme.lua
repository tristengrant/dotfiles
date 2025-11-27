-- Colour Theme: kanagawa.nvim - GitHub https://github.com/rebelot/kanagawa.nvim

return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require('kanagawa').setup({
      compile = false,              -- optional, speeds up loading if true
      transparent = true,           -- <<== make background transparent
      terminalColors = true,        -- keep terminal colors in sync

      colors = {
        theme = {
          all = {
            ui = {
                  bg_gutter = "none"
                }
              }
            }
          }
    })

    vim.cmd("colorscheme kanagawa-dragon")
  end,
}

