local M = {}

local server_base = "/misc/files/github/tristengrant-website/src/images/"
local local_base = os.getenv("HOME") .. "/Github/tristengrant-website/src/images/"

local server_script = "/misc/files/github/scripts/genalt_server.sh"
local local_script = os.getenv("HOME") .. "/Github/scripts/genalt_pc.sh"

local default_width = 1260
local default_lqip = "svg"
local default_lqip_size = 12
local default_loading = "eager"
local fallback_alt_text = "Image"

local highlight_group = "Visual"
local highlight_time = 800 -- ms

local snippet_history = {}

local function trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

local function to_import_var(path)
  local parts = {}
  for part in string.gmatch(path, "[^/%.]+") do
    local first = part:sub(1, 1):upper()
    parts[#parts + 1] = first .. part:sub(2)
  end
  return table.concat(parts)
end

local function import_exists(varname)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    if line:match("import%s+.*" .. varname) then
      return true
    end
  end
  return false
end

local function insert_import(varname, astropath)
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local insert_line = 0
  for idx, line in ipairs(lines) do
    if line:match("^---") then
      insert_line = idx
    end
  end
  local import_line = string.format('import %s from "%s"', varname, astropath)
  vim.api.nvim_buf_set_lines(0, insert_line, insert_line, false, { import_line })
end

local function insert_snippet(varname, alt_text, width, lqip, lqip_size, loading)
  width = width or default_width
  lqip = lqip or default_lqip
  lqip_size = lqip_size or default_lqip_size
  loading = loading or default_loading

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local snippet = string.format(
    '<Picture src={%s} alt="%s" width={%d} lqip="%s" lqipSize={%d} loading={"%s"} />',
    varname,
    alt_text,
    width,
    lqip,
    lqip_size,
    loading
  )
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { snippet })
  vim.api.nvim_buf_add_highlight(0, -1, highlight_group, row - 1, col, col + #snippet)
  vim.defer_fn(function()
    vim.api.nvim_buf_clear_namespace(0, -1, row - 1, row)
  end, highlight_time)

  table.insert(snippet_history, { varname = varname, alt = alt_text, snippet = snippet })
end

local function generate_alt_async(script_path, full_img_path, callback)
  vim.fn.jobstart({ script_path, full_img_path }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        local alt_text = trim(table.concat(data, " "))
        if alt_text == "" then
          alt_text = fallback_alt_text
        end
        vim.schedule(function()
          callback(alt_text)
        end)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.schedule(function()
          vim.notify("AI Error: " .. table.concat(data, " "), vim.log.levels.ERROR)
          callback(fallback_alt_text)
        end)
      end
    end,
  })
end

function M.insert_image()
  vim.ui.input({ prompt = "Enter image relative path (with extension, e.g., about/headshot.jpg): " }, function(input)
    if not input or input == "" then
      return
    end

    local astropath = "../../../images/" .. input
    local varname = to_import_var(input)

    -- Determine file system path
    local full_img_path_server = server_base .. input
    local full_img_path_local = local_base .. input
    local full_img_path
    local script_path

    if vim.fn.filereadable(full_img_path_server) == 1 then
      full_img_path = full_img_path_server
      script_path = server_script
    elseif vim.fn.filereadable(full_img_path_local) == 1 then
      full_img_path = full_img_path_local
      script_path = local_script
    else
      vim.notify("File does not exist: " .. full_img_path_local, vim.log.levels.ERROR)
      return
    end

    if not import_exists(varname) then
      insert_import(varname, astropath)
    end

    vim.notify("Generating alt text for " .. varname .. "...", vim.log.levels.INFO)
    generate_alt_async(script_path, full_img_path, function(alt)
      insert_snippet(varname, alt)
    end)
  end)
end

function M.bulk_insert_images()
  vim.ui.input({ prompt = "Enter comma-separated image paths: " }, function(input)
    if not input or input == "" then
      return
    end
    for img in string.gmatch(input, "[^,]+") do
      local path = trim(img)
      -- Directly call insert_image with prefilled path
      M.insert_image_prefilled(path)
    end
  end)
end

-- Helper to allow prefilled input for bulk inserts
function M.insert_image_prefilled(input)
  local astropath = "../../../images/" .. input
  local varname = to_import_var(input)

  local full_img_path_server = server_base .. input
  local full_img_path_local = local_base .. input
  local full_img_path
  local script_path

  if vim.fn.filereadable(full_img_path_server) == 1 then
    full_img_path = full_img_path_server
    script_path = server_script
  elseif vim.fn.filereadable(full_img_path_local) == 1 then
    full_img_path = full_img_path_local
    script_path = local_script
  else
    vim.notify("File does not exist: " .. full_img_path_local, vim.log.levels.ERROR)
    return
  end

  if not import_exists(varname) then
    insert_import(varname, astropath)
  end

  vim.notify("Generating alt text for " .. varname .. "...", vim.log.levels.INFO)
  generate_alt_async(script_path, full_img_path, function(alt)
    insert_snippet(varname, alt)
  end)
end

function M.get_snippet_history()
  return snippet_history
end

return M
