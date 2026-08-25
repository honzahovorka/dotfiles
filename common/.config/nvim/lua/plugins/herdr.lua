return {
	"ChmaraX/herdr-nvim",
	opts = {
		prefix = "<leader>n",
		-- Keymaps are set below instead, so the herdr sidebar daemon's second
		-- setup() call maps nothing and stops warning about existing maps.
		keymaps = false,
	},
	config = function(_, opts)
		local herdr = require("herdr-nvim")

		herdr.setup(opts)

		local map = vim.keymap.set

		map("x", "<leader>nc", function()
			herdr.comment_selection()
		end, { desc = "herdr-nvim: comment selection" })
		map("n", "<leader>nc", function()
			herdr.comment_line()
		end, { desc = "herdr-nvim: comment line" })
		map("n", "<leader>nl", function()
			herdr.list_comments()
		end, { desc = "herdr-nvim: list comments" })
		map("n", "<leader>ns", function()
			herdr.send_all({ submit = false })
		end, { desc = "herdr-nvim: paste comments to agent" })
		map("n", "<leader>nS", function()
			herdr.send_all({ submit = true })
		end, { desc = "herdr-nvim: send comments to agent" })
	end,
}
