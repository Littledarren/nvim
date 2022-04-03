local tools = {}
local conf = require("modules.tools.config")

-- 应该类似库函数了，好像很多插件依赖这个
tools["RishabhRD/popfix"] = {}
tools["nvim-lua/plenary.nvim"] = {}

-- fuzzy search
tools["nvim-telescope/telescope.nvim"] = {
	opt = true,
	module = "telescope",
	cmd = "Telescope",
	config = conf.telescope,
	requires = {
		{ "nvim-lua/plenary.nvim"},
		{ "nvim-lua/popup.nvim", opt = true },
	},
}
tools["xiyaowong/telescope-emoji.nvim"] = {
	opt = true,
	after = "telescope.nvim",
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

tools["sudormrfbin/cheatsheet.nvim"] = { opt = true, cmd = "Cheatsheet" }
-- popular
tools["folke/which-key.nvim"] = {
	config = function()
		require("which-key").setup({})
	end,
}
-- a more adventurous wildmenu
tools["gelguy/wilder.nvim"] = {
	event = "CmdlineEnter",
	config = conf.wilder,
	requires = { { "romgrk/fzy-lua-native", after = "wilder.nvim" } },
}

tools["bfredl/nvim-luadev"] = {
	opt = true,
	cmd = "Luadev",
}
-- align ...
tools["junegunn/vim-easy-align"] = { opt = true, cmd = "EasyAlign" }

-- highlight todo list
tools["folke/todo-comments.nvim"] = {
	config = function()
        local ok, comm = pcall(require, "todo-comments")
        if ok then
            comm.setup{}
        end
	end,
}

tools["wakatime/vim-wakatime"] = {
	cond = function()
		local allowedMachines = { "LAPTOP-syncrack", "architect" }
		local hostName = vim.loop.os_gethostname()
		for _, value in ipairs(allowedMachines) do
			if value == hostName then
				return true
			end
		end
		return false
	end,
}
-- StartupTime profile
tools["dstein64/vim-startuptime"] = { opt = true, cmd = "StartupTime" }

tools["nathom/filetype.nvim"] = {
	config = function()
		require("filetype").setup({})
	end,
}
tools["lewis6991/impatient.nvim"] = {}

return tools
