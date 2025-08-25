-- ~/.config/nvim/lua/utils/mdx_imports.lua
local M = {}

local function trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

-- Normalize quotes: convert all double quotes to single quotes
local function normalize_quotes(line)
  return line:gsub('"(.-)"', "'%1'")
end

-- Detect if line is a fenced code block start/end
local function is_fence(line)
  return line:match("^```") or line:match("^~~~")
end

-- Detect if line is a <pre> block start/end
local function is_pre_block_start(line)
  return line:match("^<pre>")
end

local function is_pre_block_end(line)
  return line:match("^</pre>")
end

-- Process imports and content, avoiding code blocks
local function process_imports(lines)
  local imports_set = {}
  local other_lines = {}
  local in_code_block = false
  local in_pre_block = false

  for _, line in ipairs(lines) do
    local trimmed = trim(line)

    if is_fence(trimmed) then
      in_code_block = not in_code_block
    end
    if is_pre_block_start(trimmed) then
      in_pre_block = true
    end
    if is_pre_block_end(trimmed) then
      in_pre_block = false
    end

    local normalized = normalize_quotes(trimmed)

    if not in_code_block and not in_pre_block and normalized:match("^import%s+") then
      imports_set[normalized] = true -- deduplicate
    else
      table.insert(other_lines, line)
    end
  end

  -- Separate named imports `{ ... }` from default imports
  local named_imports = {}
  local default_imports = {}

  for imp in pairs(imports_set) do
    if imp:match("^import%s+{") then
      table.insert(named_imports, imp)
    else
      table.insert(default_imports, imp)
    end
  end

  table.sort(named_imports)
  table.sort(default_imports)

  -- Combine named imports first, then default imports
  local sorted_imports = {}
  for _, imp in ipairs(named_imports) do
    table.insert(sorted_imports, imp)
  end
  for _, imp in ipairs(default_imports) do
    table.insert(sorted_imports, imp)
  end

  return sorted_imports, other_lines
end

-- Find end of frontmatter (---)
local function find_frontmatter_end(lines)
  if lines[1] and trim(lines[1]) == "---" then
    for i = 2, #lines do
      if trim(lines[i]) == "---" then
        return i
      end
    end
  end
  return 0
end

-- Format current buffer: deduplicate, normalize quotes, sort imports
function M.format_buffer()
  local buf = vim.api.nvim_get_current_buf()
  local ft = vim.bo[buf].filetype
  if ft ~= "mdx" and ft ~= "markdown" and ft ~= "md" then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local imports, content = process_imports(lines)
  local frontmatter_end = find_frontmatter_end(lines)

  local new_lines = {}
  for i = 1, frontmatter_end do
    table.insert(new_lines, lines[i])
  end

  -- Insert sorted imports after frontmatter
  for _, imp in ipairs(imports) do
    table.insert(new_lines, imp)
  end

  -- Insert remaining content
  for _, line in ipairs(content) do
    table.insert(new_lines, line)
  end

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, new_lines)
end

-- Optional: setup autocommands for .mdx/.md files
function M.setup_autocmd()
  vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "BufNewFile" }, {
    pattern = { "*.mdx", "*.md" },
    callback = function()
      M.format_buffer()
    end,
  })

  vim.api.nvim_create_user_command("FormatMDX", function()
    M.format_buffer()
  end, { desc = "Deduplicate, normalize, and sort imports in MDX/MD" })
end

return M
