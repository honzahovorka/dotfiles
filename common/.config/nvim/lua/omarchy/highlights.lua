local M = {}

local groups = {
	"Normal",
	"NormalFloat",
	"FloatBorder",
	"Pmenu",
	"Terminal",
	"EndOfBuffer",
	"FoldColumn",
	"Folded",
	"SignColumn",
	"LineNr",
	"CursorLineNr",
	"NormalNC",
	"WhichKeyFloat",
	"TelescopeBorder",
	"TelescopeNormal",
	"TelescopePromptBorder",
	"TelescopePromptTitle",
	"NeoTreeNormal",
	"NeoTreeNormalNC",
	"NeoTreeVertSplit",
	"NeoTreeWinSeparator",
	"NeoTreeEndOfBuffer",
	"NvimTreeNormal",
	"NvimTreeVertSplit",
	"NvimTreeEndOfBuffer",
	"NotifyINFOBody",
	"NotifyERRORBody",
	"NotifyWARNBody",
	"NotifyTRACEBody",
	"NotifyDEBUGBody",
	"NotifyINFOTitle",
	"NotifyERRORTitle",
	"NotifyWARNTitle",
	"NotifyTRACETitle",
	"NotifyDEBUGTitle",
	"NotifyINFOBorder",
	"NotifyERRORBorder",
	"NotifyWARNBorder",
	"NotifyTRACEBorder",
	"NotifyDEBUGBorder",
}

local function make_transparent(name)
	local ok, highlight = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
	if not ok or vim.tbl_isempty(highlight) then
		return
	end

	highlight.bg = nil
	vim.api.nvim_set_hl(0, name, highlight)
end

function M.apply()
	for _, group in ipairs(groups) do
		make_transparent(group)
	end
end

function M.setup()
	local group = vim.api.nvim_create_augroup("OmarchyThemeHighlights", { clear = true })
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = group,
		callback = M.apply,
		desc = "Restore transparent UI highlights after a theme change",
	})
end

return M
