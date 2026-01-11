return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofumpt" },
			yaml = { "yamlfmt" },
			c = {},
			html = {},
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
			-- typescript = { "prettierd", "prettier", stop_after_first = true },
		},

		format_on_save = function(bufnr)
			local fname = vim.api.nvim_buf_get_name(bufnr)

			-- Skip formatting for Suckless source trees
			local skip_dirs = {
				"/dwm/",
				"/dmenu/",
				"/tabbed/",
				"/slock/",
				"/dwmblocks-async/",
				"/suckless/",
				"/st/",
			}

			for _, dir in ipairs(skip_dirs) do
				if fname:find(dir) then
					return
				end
			end

			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
	},
}
