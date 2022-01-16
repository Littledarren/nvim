local tools = {}
local conf = require("modules.tools.config")

-- 应该类似库函数了，好像很多插件依赖这个
tools["RishabhRD/popfix"] = {opt = false}
tools["nvim-lua/plenary.nvim"] = {opt = false}

-- fuzzy search
tools["nvim-telescope/telescope.nvim"] = {
    opt = true,
    module = "telescope",
    cmd = "Telescope",
    config = conf.telescope,
    requires = {
        {"nvim-lua/plenary.nvim", opt = false},
        {"nvim-lua/popup.nvim", opt = true}
    }
}
tools["nvim-telescope/telescope-fzf-native.nvim"] = {
    opt = true,
    run = "make",
    after = "telescope.nvim"
}
tools["nvim-telescope/telescope-project.nvim"] = {
    opt = true,
    after = "telescope.nvim"
}
tools["nvim-telescope/telescope-frecency.nvim"] = {
    opt = true,
    after = "telescope.nvim",
    requires = {{"tami5/sqlite.lua", opt = true}}
}
tools["jvgrootveld/telescope-zoxide"] = {opt = true, after = "telescope.nvim"}

-- 快跑！
tools["thinca/vim-quickrun"] = {opt = true, cmd = {"QuickRun", "Q"}}
-- 我是说代码快跑
tools["michaelb/sniprun"] = {
    opt = true,
    run = "bash ./install.sh",
    cmd = {"SnipRun", "'<,'>SnipRun"}
}
-- popular
tools["folke/which-key.nvim"] = {
    config = function() require("which-key").setup {} end
}
-- better diagnostics
tools["folke/trouble.nvim"] = {
    opt = true,
    cmd = {"Trouble", "TroubleToggle", "TroubleRefresh"},
    config = conf.trouble
}
-- StartupTime profile
tools["dstein64/vim-startuptime"] = {opt = true, cmd = "StartupTime"}

-- a more adventurous wildmenu
tools["gelguy/wilder.nvim"] = {
    event = "CmdlineEnter",
    config = conf.wilder,
    requires = {{"romgrk/fzy-lua-native", after = "wilder.nvim"}}
}

return tools
