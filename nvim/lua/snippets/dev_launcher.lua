-- ~/.config/nvim/lua/snippets/dev_launcher.lua
local M = {}

-- Hardcoded project roots
local astro_projects = {
  "/home/tristen/Github/tristengrant-website",
  "/home/tristen/Github/catandbot-website",
}

local notes_project = "/home/tristen/Github/tristengrant-website/src/content/notes"

-- Track running jobs by root dir
local running_jobs = {}

-- Helper: check if cwd is inside a given root
local function is_subdir(cwd, root)
  return cwd:sub(1, #root) == root
end

-- Launch in browser (Linux-friendly, xdg-open)
local function open_browser(url)
  vim.fn.jobstart({ "xdg-open", url }, { detach = true })
end

M.run_dev = function()
  local cwd = vim.fn.getcwd()

  -- Notes project check
  if is_subdir(cwd, notes_project) then
    vim.notify("📝 You're in the notes project (" .. notes_project .. "). No dev server to run.", vim.log.levels.INFO)
    return
  end

  -- Astro projects check
  for _, project_root in ipairs(astro_projects) do
    if is_subdir(cwd, project_root) then
      -- Prevent duplicate server
      if running_jobs[project_root] then
        vim.notify("⚠️ " .. project_root .. " - Astro dev server already running.", vim.log.levels.WARN)
        return
      end

      vim.notify("🚀 Starting Astro dev server in " .. project_root, vim.log.levels.INFO)

      local job_id = vim.fn.jobstart({ "npm", "run", "dev" }, {
        cwd = project_root,
        on_stdout = function(_, data)
          if data then
            for _, line in ipairs(data) do
              if line ~= "" then
                print("[Astro] " .. line)
                -- Open browser if URL detected
                local url = line:match("http://127.0.0.1:%d+")
                if url then
                  open_browser(url)
                end
              end
            end
          end
        end,
        on_stderr = function(_, data)
          if data then
            for _, line in ipairs(data) do
              if line ~= "" then
                vim.notify("[Astro Error] " .. line, vim.log.levels.ERROR)
              end
            end
          end
        end,
        on_exit = function(_, code)
          running_jobs[project_root] = nil
          if code == 0 then
            vim.notify("✅ Astro dev server stopped in " .. project_root, vim.log.levels.INFO)
          else
            vim.notify("❌ Astro dev server exited with code " .. code .. " in " .. project_root, vim.log.levels.ERROR)
          end
        end,
      })

      if job_id <= 0 then
        vim.notify("❌ Failed to start Astro dev server in " .. project_root, vim.log.levels.ERROR)
      else
        running_jobs[project_root] = job_id
      end

      return
    end
  end

  -- If we reach here, no match
  vim.notify("⚠️ No dev command configured for: " .. cwd, vim.log.levels.WARN)
end

return M
