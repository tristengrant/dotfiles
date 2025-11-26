-- Harpoon - Get where you want to be with few keystrokes
-- GitHub - https://github.com/ThePrimeagen/harpoon/tree/harpoon2

return {
  {
    "ThePrimeagen/harpoon",
    lazy = false,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
    end,
  },
}

