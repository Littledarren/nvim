local ui = {}
local conf = require("modules.ui.config")

-- 获取icon
ui["kyazdani42/nvim-web-devicons"] = { opt = false }
-- colorscheme
-- ui["sainnhe/edge"] = { opt = false, config = conf.edge }
-- ui["lifepillar/vim-gruvbox8"] = { opt = false }
-- colorscheme maybe?
ui["catppuccin/nvim"] = {
	opt = false,
	as = "catppuccin",
	config = conf.catppuccin,
}
-- 启动页，当然也有一些功能。。。
ui["glepnir/dashboard-nvim"] = { opt = true, event = "BufWinEnter" }

-- 类似indentline
ui["lukas-reineke/indent-blankline.nvim"] = {
	opt = true,
	event = "BufRead",
	config = conf.indent_blankline,
}
-- 显示scroll bar on the right side
ui["dstein64/nvim-scrollview"] = { opt = true, event = "BufRead" }

-- Show where your cursor moves when jumping large distances (e.g between windows). Fast and lightweight, written completely in Lua.
ui["edluffy/specs.nvim"] = {
	opt = true,
	event = "CursorMoved",
	config = conf.specs,
}

return ui
