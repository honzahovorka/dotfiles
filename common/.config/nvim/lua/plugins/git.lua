return {
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
		keys = {
			{ "<leader>gg", "<cmd>G<cr>", desc = "Fugitive status" },
		},
	},
	{
		"sindrets/diffview.nvim",
		opts = {
			view = {
				merge_tool = {
					layout = "diff3_mixed",
				},
			},
		},
	},
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitsigns").setup()

			vim.keymap.set("n", "<leader>gs", ":Gitsigns<CR>", { silent = true })
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- Route GPG pinentry to a GUI popup (pinentry-qt) for Neogit's async
			-- commits; terminal git keeps the inline pinentry-tty. See ~/.gnupg/pinentry-switch.
			vim.env.PINENTRY_USER_DATA = "gui"
			require("neogit").setup({
				integrations = {
					diffview = true,
				},
			})

			vim.keymap.set("n", "<leader>gg", ":Neogit<CR>", { silent = true })
		end,
	},
}
