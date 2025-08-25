-- https://github.com/neovim/nvim-lspconfig/blob/master/lsp/eslint.lua

local ROOT_MARKERS = {
	'.eslintrc',
	'.eslintrc.cjs',
	'.eslintrc.js',
	'.eslintrc.json',
	'.eslintrc.yaml',
	'.eslintrc.yml',
	'eslint.config.cjs',
	'eslint.config.cts',
	'eslint.config.js',
	'eslint.config.mjs',
	'eslint.config.mts',
	'eslint.config.ts',
}

return {
	cmd = {
		'vscode-eslint-language-server',
		'--stdio',
	},
	filetypes = {
		'javascript',
		'javascript.jsx',
		'javascriptreact',
		'typescript',
		'typescript.tsx',
		'typescriptreact',
	},
	root_markers = ROOT_MARKERS,
	root_dir = function(bufnr, on_dir)
		local filename = vim.api.nvim_buf_get_name(bufnr)
		-- Only attach if there's some eslint config file in the root directory.
		local root_dir = vim.fs.dirname(vim.fs.find(ROOT_MARKERS, { path = filename, upward = true })[1])
		if not root_dir then
			return nil
		end

		on_dir(root_dir)
	end,
	-- https://github.com/Microsoft/vscode-eslint#settings-options
	settings = {
		validate = 'on',
		packageManager = nil,
		useESLintClass = false,
		experimental = {
			useFlatConfig = false,
		},
		codeActionOnSave = {
			enable = false,
			mode = 'all',
		},
		format = true,
		quiet = false,
		onIgnoredFiles = 'off',
		rulesCustomizations = {},
		run = 'onType',
		problems = {
			shortenToSingleLine = false,
		},
		-- nodePath configures the directory in which the eslint server should start its node_modules resolution.
		-- This path is relative to the workspace folder (root dir) of the server instance.
		nodePath = '',
		-- Use the workspace folder location or the file location (if no workspace folder is open) as the working directory
		workingDirectory = { mode = 'location' },
		codeAction = {
			disableRuleComment = {
				enable = true,
				location = 'separateLine',
			},
			showDocumentation = {
				enable = true,
			},
		},
	},
	handlers = {
		['eslint/openDoc'] = function(_, result)
			if result then
				vim.ui.open(result.url)
			end
			return {}
		end,
		['eslint/confirmESLintExecution'] = function(_, result)
			if not result then
				return
			end
			return 4 -- approved
		end,
		['eslint/probeFailed'] = function()
			vim.notify('[lspconfig] ESLint probe failed.', vim.log.levels.WARN)
			return {}
		end,
		['eslint/noLibrary'] = function()
			vim.notify('[lspconfig] Unable to find ESLint library.', vim.log.levels.WARN)
			return {}
		end,
	},
}

