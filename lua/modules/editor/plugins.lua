local editor = {}
local conf = require("modules.editor.config")

editor["terrortylor/nvim-comment"] = {
	opt = false,
	config = function()
		require("nvim_comment").setup({
			create_mappings = false,
			hook = function()
				require("ts_context_commentstring.internal").update_commentstring()
			end,
		})
	end,
}
-- tagbar based on lsp
editor["simrat39/symbols-outline.nvim"] = {
	opt = true,
	cmd = { "SymbolsOutline", "SymbolsOutlineOpen" },
	config = conf.symbols_outline,
}
editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufRead",
	config = conf.nvim_treesitter,
}
editor["nvim-treesitter/nvim-treesitter-textobjects"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["romgrk/nvim-treesitter-context"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["p00f/nvim-ts-rainbow"] = {
	opt = true,
	after = "nvim-treesitter",
	event = "BufRead",
}
editor["JoosepAlviste/nvim-ts-context-commentstring"] = {
	opt = true,
	after = "nvim-treesitter",
}
editor["mfussenegger/nvim-ts-hint-textobject"] = {
	opt = true,
	after = "nvim-treesitter",
}
-- for html tags
editor["windwp/nvim-ts-autotag"] = {
	opt = true,
	ft = { "html", "xml" },
	config = conf.autotag,
}
-- like vim matchit
editor["andymass/vim-matchup"] = {
	opt = true,
	after = "nvim-treesitter",
	config = conf.matchup,
}
-- 让jk移动更快
editor["rhysd/accelerated-jk"] = { opt = true }
-- elimate the hlsearch after searching
editor["romainl/vim-cool"] = {
	opt = true,
	event = { "CursorMoved", "InsertEnter" },
}
-- like easymotion
editor["phaazon/hop.nvim"] = {
	opt = true,
	branch = "v1",
	cmd = {
		"HopLine",
		"HopLineStart",
		"HopWord",
		"HopPattern",
		"HopChar1",
		"HopChar2",
	},
	config = function()
		require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
	end,
}
-- 平滑滚动
editor["karb94/neoscroll.nvim"] = {
	opt = true,
	event = "WinScrolled",
	config = conf.neoscroll,
}
-- 终端优化，感觉没啥用
editor["vimlab/split-term.vim"] = {
	opt = true,
	cmd = { "Term", "VTerm" },
}
-- editor["akinsho/nvim-toggleterm.lua"] = {
--     opt = true,
--     event = "BufRead",
--     config = conf.toggleterm
-- }
editor["numtostr/FTerm.nvim"] = { opt = false }

-- show color for color code like #ff00ff
editor["norcalli/nvim-colorizer.lua"] = {
	opt = true,
	event = "BufRead",
	config = conf.nvim_colorizer,
}
-- auto_session 好像没用
editor["rmagatti/auto-session"] = {
	opt = true,
	cmd = { "SaveSession", "RestoreSession", "DeleteSession" },
	config = conf.auto_session,
}
-- map jk to <esc>?
editor["jdhao/better-escape.vim"] = { opt = true, event = "InsertEnter" }

-- debug ui
editor["rcarriga/nvim-dap-ui"] = {
	opt = false,
	config = conf.dapui,
	requires = {
		{ "mfussenegger/nvim-dap", config = conf.dap },
		{
			"Pocco81/DAPInstall.nvim",
			opt = true,
			cmd = { "DIInstall", "DIUninstall", "DIList" },
			config = conf.dapinstall,
		},
	},
}
-- git fugitive
editor["tpope/vim-fugitive"] = { opt = true, cmd = { "Git", "G" } }
editor["famiu/bufdelete.nvim"] = {
	opt = true,
	cmd = { "Bdelete", "Bwipeout", "Bdelete!", "Bwipeout!" },
}
editor["ojroques/vim-oscyank"] = {
	opt = true,
	cmd = { "OSCYank" },
}
-- statusline
editor["arkav/lualine-lsp-progress"] = {
	opt = true,
	after = "nvim-lspconfig",
}
editor["hoob3rt/lualine.nvim"] = {
	opt = true,
	config = conf.lualine,
	after = "nvim-lspconfig",
}
-- bufferline 类似airline的那个。
editor["akinsho/nvim-bufferline.lua"] = {
	opt = true,
	event = "BufRead",
	config = conf.nvim_bufferline,
}
-- 文件浏览器
editor["kyazdani42/nvim-tree.lua"] = {
	opt = true,
	cmd = { "NvimTreeToggle", "NvimTreeOpen" },
	config = conf.nvim_tree,
}
-- 类似vscode的git
editor["lewis6991/gitsigns.nvim"] = {
	opt = true,
	event = { "BufRead", "BufNewFile" },
	config = conf.gitsigns,
	requires = { "nvim-lua/plenary.nvim", opt = true },
}

-- better diagnostics
editor["folke/trouble.nvim"] = {
	opt = true,
	cmd = { "Trouble", "TroubleToggle", "TroubleRefresh" },
	config = conf.trouble,
}

-- 快跑！
editor["thinca/vim-quickrun"] = { opt = true, cmd = { "QuickRun", "Q" } }
-- 我是说代码快跑
editor["michaelb/sniprun"] = {
	opt = true,
	run = "bash ./install.sh",
	cmd = { "SnipRun", "'<,'>SnipRun" },
}
return editor
