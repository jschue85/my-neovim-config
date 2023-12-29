local lsp_zero = require('lsp-zero')
--lsp_zero.nvim_workspace()
lsp_zero.preset("recommended")

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	lsp_zero.default_keymaps({ buffer = bufnr })
	lsp_zero.buffer_autoformat()
	lsp_zero.highlight_symbol(client, bufnr)
end)
lsp_zero.set_sign_icons({
	error = '✘',
	warn = '▲',
	hint = '⚑',
	info = '»'
})
lsp_zero.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		["golang"] = { "gopls" },
		["lua"] = { "lua_ls" }
	}
})
lsp_zero.configure("gopls", {
	settings = {
		completions = {
			completeFunctionCalls = true
		}
	}
})

require('mason').setup({})
require('mason-lspconfig').setup({
	ensure_installed = { "gopls", "lua_ls" },
	handlers = {
		lsp_zero.default_setup,
	},
})
