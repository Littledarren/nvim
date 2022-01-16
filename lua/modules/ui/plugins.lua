local ui = {}
local conf = require("modules.ui.config")

-- 获取icon
ui["kyazdani42/nvim-web-devicons"] = {opt = false}
-- colorscheme
ui["sainnhe/edge"] = {opt = false, config = conf.edge}
-- colorscheme maybe?
ui["catppuccin/nvim"] = {
    opt = false,
    as = "catppuccin",
    config = conf.catppuccin
}
-- statusline
ui["arkav/lualine-lsp-progress"] = {opt = true, after = "nvim-gps"}
ui["hoob3rt/lualine.nvim"] = {
    opt = true,
    after = "lualine-lsp-progress",
    config = conf.lualine
}
-- bufferline 类似airline的那个。
ui["akinsho/nvim-bufferline.lua"] = {
    opt = true,
    event = "BufRead",
    config = conf.nvim_bufferline
}
-- 启动页，当然也有一些功能。。。
ui["glepnir/dashboard-nvim"] = {opt = true, event = "BufWinEnter"}
-- 文件浏览器
ui["kyazdani42/nvim-tree.lua"] = {
    opt = true,
    cmd = {"NvimTreeToggle", "NvimTreeOpen"},
    config = conf.nvim_tree
}
-- 类似vscode的git
ui["lewis6991/gitsigns.nvim"] = {
    opt = true,
    event = {"BufRead", "BufNewFile"},
    config = conf.gitsigns,
    requires = {"nvim-lua/plenary.nvim", opt = true}
}
-- 类似indentline
ui["lukas-reineke/indent-blankline.nvim"] = {
    opt = true,
    event = "BufRead",
    config = conf.indent_blankline
}
-- 显示scroll bar on the right side
ui["dstein64/nvim-scrollview"] = {opt = true, event = "BufRead"}

return ui
