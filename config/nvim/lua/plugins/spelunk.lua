return {
  {
    "EvWilson/spelunk.nvim",
    dependencies = {
			'nvim-telescope/telescope.nvim',   -- Optional: for enhanced fuzzy search capabilities
			'folke/snacks.nvim',               -- Optional: for enhanced fuzzy search capabilities
			'ibhagwan/fzf-lua',                -- Optional: for enhanced fuzzy search capabilities
			'nvim-treesitter/nvim-treesitter', -- Optional: for showing grammar context
			'nvim-lualine/lualine.nvim',       -- Optional: for statusline display integration
		},
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  }
}
