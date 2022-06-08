local ui = {}
local conf = require("modules.ui.config")

-- 获取icon
ui["kyazdani42/nvim-web-devicons"] = {}
-- colorscheme
ui["folke/tokyonight.nvim"] = {}
-- colorscheme maybe?
ui["catppuccin/nvim"] = {
	as = "catppuccin",
	config = conf.catppuccin,
}
ui["navarasu/onedark.nvim"] = {
	config = function()
		require("onedark").load()
	end,
}

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

return ui
