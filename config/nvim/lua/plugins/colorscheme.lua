return {
	"rebelot/kanagawa.nvim",
	branch = "master",
	config = function()
		require("kanagawa").setup({
			transparent = true,
			overrides = function(colors)
				return {
					-- your existing markdown overrides
					["@markup.link.url.markdown_inline"] = { link = "Special" },
					["@markup.link.label.markdown_inline"] = { link = "WarningMsg" },
					["@markup.italic.markdown_inline"] = { link = "Exception" },
					["@markup.raw.markdown_inline"] = { link = "String" },
					["@markup.list.markdown"] = { link = "Function" },
					["@markup.quote.markdown"] = { link = "Error" },
					["@markup.list.checked.markdown"] = { link = "WarningMsg" },

					-- make UI elements transparent
					Normal = { bg = "NONE" },
					NormalNC = { bg = "NONE" },
					SignColumn = { bg = "NONE" },
					VertSplit = { bg = "NONE" },
					StatusLine = { bg = "NONE" },
					StatusLineNC = { bg = "NONE" },
					Pmenu = { bg = "NONE" },
					PmenuSel = { bg = "NONE" },
					LineNr = { bg = "NONE" },
					CursorLineNr = { bg = "NONE" },
					Folded = { bg = "NONE" },
				}
			end,
		})

		vim.cmd("colorscheme kanagawa")

		vim.opt.guicursor = {
			"n-v-c:block-CursorNormal",
			"i:ver25-CursorInsert",
			"r-cr:hor20-CursorReplace",
			"o:hor50-CursorOperator",
		}

		vim.cmd([[
            highlight CursorNormal     guifg=NONE guibg=#BBBBBB
            highlight CursorInsert     guifg=NONE guibg=#EEEEEE
            highlight CursorReplace    guifg=NONE guibg=#444444
            highlight CursorOperator   guifg=NONE guibg=#444444
        ]])
	end,
}
