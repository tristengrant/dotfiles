-- ~/.config/nvim/lua/config/mdx_formatter.lua
local M = {}
local mdx_imports = require("utils.mdx_imports")

-- Format current buffer
function M.format_buffer()
  local ft = vim.bo.filetype
  if ft ~= "mdx" and ft ~= "markdown" and ft ~= "md" then
    return
  end
  mdx_imports.format_imports()
end

-- Setup autocommands
function M.setup_autocmd()
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "BufNewFile" }, {
    pattern = { "*.mdx", "*.md" },
    callback = function()
      M.format_buffer()
    end,
  })

  vim.api.nvim_create_user_command("FormatMDX", function()
    M.format_buffer()
  end, { desc = "Deduplicate and sort imports in MDX/MD" })
end

return M
