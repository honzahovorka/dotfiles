-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/vtsls.lua

return {
	cmd = { "vtsls", "--stdio" },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json" },
	root_dir = function(bufnr, on_dir)
		-- Use package-local markers so each package in a workspace roots at itself.
		-- Workspace lockfiles (pnpm-lock.yaml/yarn.lock) live only at the monorepo
		-- root, so using them here would drag every client up to the top.
		local node_root_markers = { "tsconfig.json", "jsconfig.json", "package.json" }
		local project_root_markers = vim.fn.has("nvim-0.11.3") == 1 and { node_root_markers, { ".git" } }
			or vim.list_extend(node_root_markers, { ".git" })
		local deno_root = vim.fs.root(bufnr, { "deno.json", "deno.jsonc" })
		local deno_lock_root = vim.fs.root(bufnr, { "deno.lock" })
		local project_root = vim.fs.root(bufnr, project_root_markers)

		if
			(deno_lock_root and (not project_root or #deno_lock_root > #project_root))
			or (deno_root and (not project_root or #deno_root >= #project_root))
		then
			return nil
		end

		if project_root then
			on_dir(project_root)
		end
	end,
}
