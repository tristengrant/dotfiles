return {
	"nvim-telekasten/telekasten.nvim",
	dependencies = {
		"nvim-telescope/telescope.nvim",
		"folke/which-key.nvim",
	},
	config = function()
		local home = vim.fn.expand("~/Documents/notes")

		require("telekasten").setup({
			home = home,
			take_over_my_home = true,
			auto_set_filetype = true,
			extension = ".md",
			filename_space_subst = "-",
			filename_small_case = true,

			-- Templates folder
			templates = vim.fn.expand("~/Documents/notes/templates"),

			-- Daily notes
			dailies = vim.fn.expand("~/Documents/notes/daily"),
			template_new_daily = vim.fn.expand("~/Documents/notes/templates/daily.md"),
			dailies_create_nonexisting = true,

			-- Other notes
			template_new_note = vim.fn.expand("~/Documents/notes/templates/default.md"),
			follow_creates_nonexisting = true,

			-- optional: weekly/monthly/etc.
			weeklies_create_nonexisting = true,
			monthlies_create_nonexisting = true,
			quarterlies_create_nonexisting = true,
			yearlies_create_nonexisting = true,

			-- time formats
			daily_template = "%Y-%m-%d",
			week_template = "%Y-W%W",
		})

		-- keybindings
		local map = vim.keymap.set
		local opts = { noremap = true, silent = true }

		map("n", "<leader>zn", "<cmd>Telekasten new_note<CR>", opts) -- new note
		map("n", "<leader>zd", "<cmd>Telekasten goto_today<CR>", opts) -- new daily note
		map("n", "<leader>zz", "<cmd>Telekasten follow_link<CR>", opts) -- open link under cursor
		map("n", "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", opts) -- backlinks
		map("n", "<leader>zf", "<cmd>Telekasten search_notes<CR>", opts) -- find/search
		map("n", "<leader>tl", "<cmd>Telekasten insert_link<CR>", opts) -- insert link
	end,
}
