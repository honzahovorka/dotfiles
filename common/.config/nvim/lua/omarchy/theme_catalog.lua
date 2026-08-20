local M = {}

local plugins = {
	{
		"ribru17/bamboo.nvim",
		name = "bamboo.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"bjarneo/aether.nvim",
		branch = "v3",
		name = "aether",
		priority = 1000,
		lazy = true,
	},
	{
		"bjarneo/hackerman.nvim",
		name = "hackerman.nvim",
		dependencies = { "bjarneo/aether.nvim" },
		priority = 1000,
		lazy = true,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = true,
	},
	{
		"neanias/everforest-nvim",
		name = "everforest-nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"kepano/flexoki-neovim",
		name = "flexoki-neovim",
		priority = 1000,
		lazy = true,
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"tahayvr/matteblack.nvim",
		name = "matteblack.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,
		lazy = true,
	},
	{
		"ficcdaf/ashen.nvim",
		name = "ashen.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"OldJobobo/retro-82.nvim",
		name = "retro-82.nvim",
		priority = 1000,
		lazy = true,
	},
	{
		"omacom-io/lumon.nvim",
		name = "lumon.nvim",
		priority = 1000,
		lazy = true,
	},
}

local names = {}
for _, plugin in ipairs(plugins) do
	names[plugin[1]] = plugin.name
end

function M.specs()
	return vim.deepcopy(plugins)
end

function M.name_for(repository)
	return names[repository]
end

function M.has(repository)
	return names[repository] ~= nil
end

return M
