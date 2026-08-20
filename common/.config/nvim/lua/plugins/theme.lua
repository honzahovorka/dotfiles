local Catalog = require("omarchy.theme_catalog")
local Theme = require("omarchy.theme")

local active = Theme.resolve()
local active_plugin = vim.deepcopy(active.plugin)
active_plugin.lazy = false
active_plugin.priority = 1000

local specs = Catalog.specs()
specs[#specs + 1] = active_plugin

specs[#specs + 1] = {
	"cormacrelf/dark-notify",
	cond = function()
		return not Theme.is_omarchy()
	end,
	config = function()
		require("dark_notify").run()
	end,
}

specs[#specs + 1] = {
	name = "omarchy-theme-runtime",
	dir = vim.fn.stdpath("config"),
	lazy = false,
	priority = 900,
	config = function()
		require("omarchy.theme_runtime").setup(active)
	end,
}

return specs
