return {
	"godlygeek/tabular",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.keymap.set(
			"n",
			"<leader>ft",
			"v<plug>(vimtex-ie):s/[^\\t]\\zs\\t/ \\& /g<CR>v<plug>(vimtex-ie):s/$/ \\\\\\\\/g<CR>v<plug>(vimtex-ie):Tabularize /[^\\\\]\\zs&/l1r1<CR>",
			{ noremap = true, silent = true }
		)
	end,
}
