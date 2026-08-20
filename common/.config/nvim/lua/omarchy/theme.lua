local Catalog = require("omarchy.theme_catalog")

local M = {}

local function state_root()
	local override = vim.env.OMARCHY_THEME_STATE_DIR
	if override and override ~= "" then
		return vim.fs.normalize(override)
	end

	return vim.fs.normalize(vim.fn.expand("~/.local/state/omarchy/current"))
end

local function read_file(path)
	local file, open_error = io.open(path, "r")
	if not file then
		return nil, open_error
	end

	local contents = file:read("*a")
	file:close()
	return contents
end

local function read_slug(root)
	local contents, read_error = read_file(root .. "/theme.name")
	if not contents then
		return nil, "cannot read theme.name: " .. tostring(read_error)
	end

	local slug = vim.trim(contents)
	if slug == "" then
		return nil, "theme.name is empty"
	end

	return slug
end

local function read_background(theme_dir)
	local contents = read_file(theme_dir .. "/colors.toml")
	if not contents then
		return "dark"
	end

	local mode = contents:match("[\n\r]?%s*mode%s*=%s*[\"'](light)[\"']")
		or contents:match("[\n\r]?%s*mode%s*=%s*[\"'](dark)[\"']")
	return mode or "dark"
end

local function default_plugin_name(repository)
	local name = repository:gsub("%.git$", ""):match("([^/]+)$")
	return name or repository:gsub("%W+", "_")
end

local function catppuccin_integrations()
	return {
		transparent_background = true,
		show_end_of_buffer = false,
		term_colors = false,
		dim_inactive = {
			enabled = false,
			shade = "dark",
			percentage = 0.15,
		},
		no_italic = false,
		no_bold = false,
		styles = {
			comments = { "italic" },
			conditionals = { "italic" },
			loops = {},
			functions = {},
			keywords = {},
			strings = {},
			variables = {},
			numbers = {},
			booleans = {},
			properties = {},
			types = {},
			operators = {},
		},
		color_overrides = {},
		custom_highlights = {},
		integrations = {
			blink_cmp = true,
			gitsigns = true,
			nvimtree = true,
			telescope = true,
			notify = true,
			mini = false,
			neogit = true,
			harpoon = true,
			fidget = true,
			mason = true,
			dap = true,
			dap_ui = true,
			indent_blankline = true,
			dropbar = true,
			snacks = true,
			treesitter_context = true,
			native_lsp = {
				enabled = true,
				virtual_text = {
					errors = { "italic" },
					hints = { "italic" },
					warnings = { "italic" },
					information = { "italic" },
					ok = { "italic" },
				},
				underlines = {
					errors = { "underline" },
					hints = { "underline" },
					warnings = { "underline" },
					information = { "underline" },
					ok = { "underline" },
				},
				inlay_hints = {
					background = true,
				},
			},
			flash = true,
			diffview = true,
		},
	}
end

local function normalize_plugin(plugin, fallback)
	local normalized = vim.deepcopy(plugin)
	local repository = normalized[1]

	if type(repository) ~= "string" or repository == "" then
		return nil, "theme plugin repository is missing"
	end

	normalized.name = Catalog.name_for(repository) or normalized.name or default_plugin_name(repository)
	normalized.priority = normalized.priority or 1000

	if repository == "catppuccin/nvim" then
		local local_options = catppuccin_integrations()
		if fallback then
			local_options.flavour = "mocha"
			local_options.background = {
				light = "latte",
				dark = "mocha",
			}
		end
		normalized.opts = vim.tbl_deep_extend("force", local_options, normalized.opts or {})
	end

	return normalized
end

local function load_specs(path)
	-- Omarchy atomically replaces the theme directory while keeping this path
	-- stable. Compile the freshly read source so vim.loader cannot reuse bytecode
	-- cached for the previous theme at the same path.
	local contents, read_error = read_file(path)
	if not contents then
		return nil, "cannot read neovim.lua: " .. tostring(read_error)
	end

	local chunk, load_error = load(contents, "@" .. path, "t")
	if not chunk then
		return nil, "cannot load neovim.lua: " .. tostring(load_error)
	end

	local ok, specs = pcall(chunk)
	if not ok then
		return nil, "cannot evaluate neovim.lua: " .. tostring(specs)
	end
	if type(specs) ~= "table" then
		return nil, "neovim.lua did not return a plugin-spec table"
	end

	return specs
end

---@param root? string
---@return table? theme
---@return string? error
function M.current(root)
	root = root and vim.fs.normalize(root) or state_root()
	local theme_dir = root .. "/theme"
	local slug, slug_error = read_slug(root)
	if not slug then
		return nil, slug_error
	end

	local specs, specs_error = load_specs(theme_dir .. "/neovim.lua")
	if not specs then
		return nil, specs_error
	end

	local plugin
	local colorscheme
	for _, spec in ipairs(specs) do
		if type(spec) == "table" and spec[1] == "LazyVim/LazyVim" then
			if type(spec.opts) == "table" and type(spec.opts.colorscheme) == "string" then
				colorscheme = spec.opts.colorscheme
			end
		elseif not plugin and type(spec) == "table" and type(spec[1]) == "string" then
			plugin = spec
		end
	end

	if not plugin then
		return nil, "neovim.lua does not declare a theme plugin"
	end
	if not colorscheme or colorscheme == "" then
		return nil, "neovim.lua does not declare a LazyVim colorscheme"
	end

	local normalized, plugin_error = normalize_plugin(plugin, false)
	if not normalized then
		return nil, plugin_error
	end

	return {
		slug = slug,
		colorscheme = colorscheme,
		background = read_background(theme_dir),
		plugin = normalized,
		plugin_name = normalized.name,
		repository = normalized[1],
		registered = Catalog.has(normalized[1]),
		root = root,
		source = "omarchy",
	}
end

function M.fallback(reason)
	local plugin = assert(normalize_plugin({ "catppuccin/nvim", name = "catppuccin" }, true))
	return {
		slug = "catppuccin",
		colorscheme = "catppuccin",
		background = "dark",
		plugin = plugin,
		plugin_name = plugin.name,
		repository = plugin[1],
		registered = true,
		root = state_root(),
		source = "fallback",
		reason = reason,
	}
end

function M.resolve(root)
	local theme, current_error = M.current(root)
	if theme then
		return theme
	end

	return M.fallback(current_error)
end

function M.state_root()
	return state_root()
end

function M.is_omarchy()
	if vim.env.OMARCHY_THEME_STATE_DIR and vim.env.OMARCHY_THEME_STATE_DIR ~= "" then
		return true
	end

	return vim.fn.executable("omarchy") == 1 and vim.fn.isdirectory(state_root()) == 1
end

return M
