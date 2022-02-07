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
	opt = true,
	cmd = { "TodoQuickFix", "TodoLocList", "TodoTrouble", "TodoTelescope" },
	config = function()
		require("todo-comments").setup({})
	end,
}

tools["ellisonleao/glow.nvim"] = {
	opt = true,
	ft = "markdown",
	config = function()
		vim.api.nvim_set_keymap("n", "<leader>mp", ":Glow<CR>", {})
	end,
}

tools["wakatime/vim-wakatime"] = {
	cond = function()
		local allowedMachines = { "LAPTOP-syncrack" }
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

return tools
