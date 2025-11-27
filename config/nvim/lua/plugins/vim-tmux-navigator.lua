-- vim-tmux-navigator - Seamless navigation between Vim splits and tmux panes using the same shortcuts.
-- GitHub - https://github.com/christoomey/vim-tmux-navigator

return {
	"christoomey/vim-tmux-navigator",
  vim.keymap.set('n', 'C-h', ':TmuxNavigateLeft<CR>', { silent = true }),
  vim.keymap.set('n', 'C-j', ':TmuxNavigateDown<CR>', { silent = true }),
  vim.keymap.set('n', 'C-k', ':TmuxNavigateUp<CR>', { silent = true }),
  vim.keymap.set('n', 'C-l', ':TmuxNavigateRight<CR>', { silent = true }),
}
