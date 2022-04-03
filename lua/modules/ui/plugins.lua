local ui = {}
local conf = require("modules.ui.config")

-- 获取icon
ui["kyazdani42/nvim-web-devicons"] = {}
-- colorscheme
ui["rebelot/kanagawa.nvim"] = { opt = false, config = conf.kanagawa }
ui["folke/tokyonight.nvim"] = {}
-- colorscheme maybe?
ui["catppuccin/nvim"] = {
	opt = false,
	as = "catppuccin",
	config = conf.catppuccin,
}
ui["navarasu/onedark.nvim"] = { }

-- 启动页
ui["goolord/alpha-nvim"] = { opt = true, event = "BufWinEnter", config = conf.alpha }

-- 类似indentline
ui["lukas-reineke/indent-blankline.nvim"] = {
	opt = true,
	event = "BufRead",
	config = conf.indent_blankline,
}
-- 显示scroll bar on the right side
ui["dstein64/nvim-scrollview"] = { opt = true, event = "BufRead" }

-- Show where your cursor moves when jumping large distances (e.g between windows). Fast and lightweight, written completely in Lua.
-- ui["edluffy/specs.nvim"] = {
-- 	opt = true,
-- 	event = "CursorMoved",
-- 	config = conf.specs,
-- }

return ui
