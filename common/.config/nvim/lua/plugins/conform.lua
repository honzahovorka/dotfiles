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
		local ts_runtime = require("lsp.ts_runtime")

		-- Use the same Deno/Node ownership decision as the language servers.
		-- A package may still explicitly choose `deno fmt` while using vtsls for
		-- type checking. Within other Node projects, prefer an explicit Biome
		-- config and otherwise use the first available Prettier implementation.
		local function package_uses_deno_fmt(dir)
			local package_root = vim.fs.root(dir, { "package.json" })
			if not package_root then
				return false
			end

			local ok, package = pcall(function()
				local path = vim.fs.joinpath(package_root, "package.json")
				return vim.json.decode(table.concat(vim.fn.readfile(path), "\n"))
			end)
			local format_script = ok
				and type(package) == "table"
				and type(package.scripts) == "table"
				and package.scripts.format
			return type(format_script) == "string" and format_script:find("%f[%w]deno%s+fmt%f[%W]") ~= nil
		end

		local function web_formatters(bufnr)
			local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
			if package_uses_deno_fmt(dir) then
				return { "deno_fmt" }
			end

			local runtime = ts_runtime.resolve(bufnr)
			if runtime == "deno" then
				return { "deno_fmt" }
			end

			if vim.fs.root(dir, { "biome.json", "biome.jsonc" }) then
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
