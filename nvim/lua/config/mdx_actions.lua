-- ~/.config/nvim/lua/config/mdx_actions.lua
local M = {}

local imports_formatter = require("utils.mdx_imports")

-- Turn filename into PascalCase-ish import variable
local function to_import_var(path)
  local parts = {}
  for part in string.gmatch(path, "[^/%.]+") do
    local first = part:sub(1, 1):upper()
    parts[#parts + 1] = first .. part:sub(2)
  end
  return table.concat(parts)
end

-- Insert image boilerplate with full filename (extension included)
function M.insert_image_boilerplate()
  vim.ui.input({ prompt = "Enter filename (with extension, e.g. about/headshot.jpg): " }, function(input)
    if not input or input == "" then
      return
    end

    local import_var = to_import_var(input)

    -- Build snippet
    local snippet = string.format(
      "import %s from '../../../images/%s';\n\n<Picture src={%s} width={1260} lqip='svg' lqipSize={12} loading={'eager'} />\n\n",
      import_var,
      input,
      import_var
    )

    -- Insert snippet at cursor
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, vim.split(snippet, "\n"))

    -- Move cursor to beginning of snippet (safe)
    vim.api.nvim_win_set_cursor(0, { row - 1, 0 })

    -- Run imports formatter immediately after snippet
    imports_formatter.format_buffer()
  end)
end

-- Optional: define keymap here directly
vim.keymap.set("n", "<leader>ami", function()
  M.insert_image_boilerplate()
end, { desc = "Insert MDX image boilerplate" })

return M
