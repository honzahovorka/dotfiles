-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/vtsls.lua

local ts_runtime = require("lsp.ts_runtime")

return {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	root_dir = function(bufnr, on_dir)
		local runtime, root = ts_runtime.resolve(bufnr)
		if runtime == "node" and root then
			on_dir(root)
		end
	end,
}
