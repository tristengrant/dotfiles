-- ~/.config/nvim/lua/plugins/onedark-theme.lua

return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- This setup function is optional if you want to use the default settings
      -- If you want to customize it, you would add your options here.
      -- For example, to use the 'darker' style:
      require("onedark").setup({
        style = "dark",
      })

      -- You can also add a keybind to toggle between styles
      -- require("onedark").setup({
      --   toggle_style_key = "<leader>t",
      --   toggle_style_list = { "dark", "darker", "cool", "deep" },
      -- })
    end,
  },
}
