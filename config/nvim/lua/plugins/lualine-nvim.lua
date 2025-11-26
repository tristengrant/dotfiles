-- lualine.nvim - Blazing fast and easy to configure NeoVim statusline
-- GitHub - https://github.com/nvim-lualine/lualine.nvim

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine = require("lualine")

        lualine.setup({
            options = {
                icons_enabled = true,
                section_separators = { left = "", right = "" },
                component_separators = "|",
                globalstatus = true,
            },
        })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
}

