local Highlights = require("omarchy.highlights")
local Theme = require("omarchy.theme")

local M = {}

local state = {
	current = nil,
	last_error = nil,
	startup_error = nil,
	watcher = nil,
	timer = nil,
}

local function signal_dir()
	if vim.env.XDG_RUNTIME_DIR and vim.env.XDG_RUNTIME_DIR ~= "" then
		return vim.fs.normalize(vim.env.XDG_RUNTIME_DIR .. "/omarchy-nvim")
	end

	local uid = (vim.uv or vim.loop).getuid()
	return "/tmp/omarchy-nvim-" .. tostring(uid)
end

local function configure_plugin(theme)
	local Config = require("lazy.core.config")
	local Loader = require("lazy.core.loader")
	local plugin = Config.plugins[theme.plugin_name]
	if not plugin then
		return false, ("theme plugin %q is not registered; restart Neovim to add it"):format(theme.repository)
	end
	if not plugin._.installed then
		return false, ("theme plugin %q is not installed; run :Lazy sync and retry"):format(theme.plugin_name)
	end

	plugin.opts = theme.plugin.opts
	plugin.config = theme.plugin.config
	plugin.main = theme.plugin.main or plugin.main
	plugin._.cache = nil

	if plugin._.loaded then
		Loader.reload(plugin)
	else
		Loader.load(plugin, { start = "omarchy-theme" })
	end

	return true
end

---@param theme table
---@param options? { configure?: boolean }
function M.apply(theme, options)
	options = options or {}
	local previous_colorscheme = vim.g.colors_name
	local previous_background = vim.o.background
	local previous_theme = state.current

	local ok, apply_error = xpcall(function()
		if options.configure ~= false then
			local configured, configuration_error = configure_plugin(theme)
			if not configured then
				error(configuration_error)
			end
		end

		vim.o.background = theme.background
		require("lazy.core.loader").colorscheme(theme.colorscheme)
		vim.cmd.colorscheme(theme.colorscheme)
	end, debug.traceback)

	if not ok then
		vim.o.background = previous_background
		if previous_colorscheme then
			pcall(vim.cmd.colorscheme, previous_colorscheme)
		end
		state.current = previous_theme
		state.last_error = tostring(apply_error)
		return false, state.last_error
	end

	state.current = theme
	state.last_error = nil
	return true
end

---@param notify? boolean
function M.reload(notify)
	local theme, current_error = Theme.current()
	if not theme then
		state.last_error = current_error
		if notify then
			vim.notify(current_error, vim.log.levels.ERROR, { title = "Omarchy theme" })
		end
		return false, current_error
	end

	local ok, reload_error = M.apply(theme)
	if notify then
		if ok then
			vim.notify(("Applied %s (%s)"):format(theme.slug, theme.colorscheme), vim.log.levels.INFO, {
				title = "Omarchy theme",
			})
		else
			vim.notify(reload_error, vim.log.levels.ERROR, { title = "Omarchy theme" })
		end
	end

	return ok, reload_error
end

function M.info()
	local current = state.current or Theme.resolve()
	return {
		mode = current.source,
		slug = current.slug,
		configured_colorscheme = current.colorscheme,
		active_colorscheme = vim.g.colors_name,
		background = vim.o.background,
		plugin = current.plugin_name,
		repository = current.repository,
		registered = current.registered,
		state_root = Theme.state_root(),
		signal = signal_dir() .. "/theme",
		startup_error = state.startup_error,
		last_error = state.last_error,
	}
end

local function stop_watcher()
	for _, handle in ipairs({ state.timer, state.watcher }) do
		if handle and not handle:is_closing() then
			handle:stop()
			handle:close()
		end
	end
	state.timer = nil
	state.watcher = nil
end

local function start_watcher()
	if not Theme.is_omarchy() or state.watcher then
		return
	end

	local directory = signal_dir()
	vim.fn.mkdir(directory, "p")

	local uv = vim.uv or vim.loop
	state.watcher = assert(uv.new_fs_event())
	state.timer = assert(uv.new_timer())

	local started, watch_error = state.watcher:start(directory, {}, function(error_message, filename)
		if error_message then
			state.last_error = "theme signal watcher failed: " .. tostring(error_message)
			return
		end
		if filename and filename ~= "theme" then
			return
		end

		state.timer:stop()
		state.timer:start(
			120,
			0,
			vim.schedule_wrap(function()
				M.reload(false)
			end)
		)
	end)

	if not started then
		state.last_error = "cannot watch theme signal directory: " .. tostring(watch_error)
		stop_watcher()
	end
end

local function create_commands()
	vim.api.nvim_create_user_command("OmarchyThemeReload", function()
		M.reload(true)
	end, { desc = "Reload Neovim's current Omarchy theme" })

	vim.api.nvim_create_user_command("OmarchyThemeInfo", function()
		vim.notify(vim.inspect(M.info()), vim.log.levels.INFO, { title = "Omarchy theme" })
	end, { desc = "Show Omarchy theme integration diagnostics" })
end

function M.setup(initial_theme)
	state.startup_error = initial_theme.reason
	Highlights.setup()
	create_commands()

	local applied, apply_error = M.apply(initial_theme, { configure = false })
	if not applied and initial_theme.source ~= "fallback" then
		local fallback = Theme.fallback(apply_error)
		M.apply(fallback)
	end

	Highlights.apply()
	start_watcher()

	vim.api.nvim_create_autocmd("VimLeavePre", {
		once = true,
		callback = stop_watcher,
		desc = "Close the Omarchy theme signal watcher",
	})
end

return M
