return {
	"windwp/nvim-ts-autotag",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("nvim-ts-autotag").setup({
			filetypes = { "html", "gohtmltmpl", "xml", "javascript", "typescript", "jsx", "tsx" },
			per_filetype = {
				html = { enable_close = true },
				htmlhugo = { enable_close = true },
				javascript = { enable_close = true },
				javascriptreact = { enable_close = true },
				typescriptreact = { enable_close = true },
				vue = { enable_close = true },
			},
		})
	end,
}
