local M = {}

local deno_markers = { "deno.json", "deno.jsonc" }
local node_markers = { "tsconfig.json", "jsconfig.json", "package.json" }

---Choose exactly one TypeScript runtime for a buffer.
---
---The closest explicit project marker wins. A Deno config wins a tie because it
---is a stronger runtime declaration than package.json, which Deno projects may
---also contain for npm tooling. A git root is only a vtsls fallback when there
---is no explicit Deno or Node project marker.
---@param bufnr integer
---@return "deno"|"node" runtime
---@return string|nil root
function M.resolve(bufnr)
	local deno_root = vim.fs.root(bufnr, deno_markers)
	local node_root = vim.fs.root(bufnr, node_markers)

	if deno_root and (not node_root or #deno_root >= #node_root) then
		return "deno", deno_root
	end

	if node_root then
		return "node", node_root
	end

	return "node", vim.fs.root(bufnr, { ".git" })
end

return M
