return {
	"lervag/vimtex",
	ft = { "latex", "tex" },
	config = function()
		vim.g.vimtex_syntax_conceal_disable = true

		vim.g.vimtex_compiler_latexmk = {
			build_dir = "output",
			continuous = 0,
			options = {
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-shell-escape",
				"-interaction=nonstopmode",
			},
		}
	end,
}
