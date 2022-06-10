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
editor["stevearc/aerial.nvim"] = {
	opt = true,
	cmd = { "AerialToggle" },
	config = conf.aerial,
}
editor["nvim-treesitter/nvim-treesitter"] = {
	opt = true,
	run = ":TSUpdate",
	event = "BufRead",
	config = conf.nvim_treesitter,
}

editor["nvim-treesitter/playground"] = {
	after = "nvim-treesitter",
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
editor["rhysd/accelerated-jk"] = {}
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
-- 终端优化
editor["akinsho/toggleterm.nvim"] = {
	opt = true,
	event = "BufRead",
	config = conf.toggleterm,
}

-- show color for color code like #ff00ff
editor["norcalli/nvim-colorizer.lua"] = {
	opt = true,
	event = "BufRead",
	config = conf.nvim_colorizer,
}
-- map jk to <esc>?
editor["jdhao/better-escape.vim"] = { opt = true, event = "InsertEnter" }

-- git fugitive
editor["tpope/vim-fugitive"] = {}

editor["ojroques/vim-oscyank"] = {
	config = function()
		vim.cmd([[
            autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
        ]])
	end,
}
-- statusline
editor["arkav/lualine-lsp-progress"] = {}
editor["hoob3rt/lualine.nvim"] = {
	config = conf.lualine,
	after = { "lualine-lsp-progress", "onedark.nvim" },
}
-- bufferline 类似airline的那个。
editor["akinsho/bufferline.nvim"] = {
	opt = true,
	event = "BufRead",
	config = conf.nvim_bufferline,
}
-- 文件浏览器
editor["kyazdani42/nvim-tree.lua"] = {
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
	config = conf.trouble,
}

-- 我是说代码快跑
editor["michaelb/sniprun"] = {
	opt = true,
	run = "bash ./install.sh",
	cmd = { "SnipRun", "'<,'>SnipRun" },
}

-- beautiful vim.notify
editor["rcarriga/nvim-notify"] = {
	config = function()
		vim.notify = require("notify")
	end,
}

-- 输入法切换
editor["rlue/vim-barbaric"] = {}
return editor
