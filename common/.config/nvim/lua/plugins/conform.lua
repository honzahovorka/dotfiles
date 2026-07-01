return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- This will provide type hinting with LuaLS
	---@module 'conform'
	---@type conform.setupOpts
	opts = function()
		-- Pick the JS/TS formatter based on which project the buffer lives in,
		-- so a Deno package uses `deno fmt`, a Biome package uses biome, and
		-- everything else falls back to prettier. Mirrors the LSP root logic:
		-- the deepest (nearest) config wins.
		local function web_formatters(bufnr)
			local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
			local deno = vim.fs.root(dir, { "deno.json", "deno.jsonc", "deno.lock" })
			local biome = vim.fs.root(dir, { "biome.json", "biome.jsonc" })
			local node = vim.fs.root(dir, { "package.json", "tsconfig.json", "jsconfig.json" })

			-- Deno wins when its config is at least as deep as the node config.
			if deno and (not node or #deno >= #node) then
				return { "deno_fmt" }
			end
			if biome and (not node or #biome >= #node) then
				return { "biome" }
			end
			return { "prettierd", "prettier", stop_after_first = true }
		end

		return {
			-- Define your formatters
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = web_formatters,
				javascriptreact = web_formatters,
				typescript = web_formatters,
				typescriptreact = web_formatters,
			},
			-- Set default options
			default_format_opts = {
				lsp_format = "fallback",
			},
			-- Set up format-on-save
			format_on_save = { timeout_ms = 500 },
			-- Customize formatters
			formatters = {
				shfmt = {
					append_args = { "-i", "2" },
				},
				deno_fmt = {
					cwd = require("conform.util").root_file({ "deno.json", "deno.jsonc" }),
				},
			},
		}
	end,
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require conform('.formatexpr()')"
	end,
}
