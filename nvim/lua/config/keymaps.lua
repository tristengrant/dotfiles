-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- MDX actions
---- <leader> a m i = MDX insert image
vim.keymap.set("n", "<leader>ami", function()
  local actions = require("config.mdx_actions")
  actions.insert_image_boilerplate()
end, { desc = "Insert MDX image boilerplate" })

local launcher = require("snippets.dev_launcher")
vim.keymap.set("n", "<leader>rd", launcher.run_dev, { desc = "Run project dev server" })

-- Auto-load formatter
--local formatter = require("config.mdx_formatter")
--formatter.setup_autocmd()
