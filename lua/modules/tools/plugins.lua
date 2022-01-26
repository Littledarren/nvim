local tools = {}
local conf = require("modules.tools.config")

-- 应该类似库函数了，好像很多插件依赖这个
tools["RishabhRD/popfix"] = { opt = false }
tools["nvim-lua/plenary.nvim"] = { opt = false }

-- fuzzy search
tools["nvim-telescope/telescope.nvim"] = {
	opt = true,
	module = "telescope",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "nvim-lua/plenary.nvim", opt = false },
		{ "nvim-lua/popup.nvim", opt = true },
	},
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
	opt = true,
	run = "make",
	after = "telescope.nvim",
}
tools["nvim-telescope/telescope-project.nvim"] = {
	opt = true,
	after = "telescope.nvim",
}
tools["nvim-telescope/telescope-frecency.nvim"] = {
	opt = true,
	after = "telescope.nvim",
	requires = { { "tami5/sqlite.lua", opt = true } },
}

-- popular
tools["folke/which-key.nvim"] = {
	config = function()
		require("which-key").setup({})
	end,
}
-- StartupTime profile
tools["dstein64/vim-startuptime"] = { opt = true, cmd = "StartupTime" }

-- a more adventurous wildmenu
tools["gelguy/wilder.nvim"] = {
	event = "CmdlineEnter",
	config = conf.wilder,
	requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
}

tools["bfredl/nvim-luadev"] = {}
-- align ...
tools["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }

-- tools["akatime/vim-wakatime"] = { opt = true, cmd = { "wakatime" } }

return tools
