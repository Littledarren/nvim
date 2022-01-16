local lang = {}
local conf = require("modules.lang.config")

lang['fatih/vim-go'] = {
    opt = true,
    branch  = "v1.25",
    ft = 'go',
    run = ":GoInstallBinaries",
    config = conf.lang_go
}

lang['lervag/vimtex'] = {
    opt = true,
    ft = 'tex',
    config = conf.lang_tex
}


lang["rust-lang/rust.vim"] = {opt = true, ft = "rust"}
lang["simrat39/rust-tools.nvim"] = {
    opt = true,
    ft = "rust",
    config = conf.rust_tools,
    requires = {{"nvim-lua/plenary.nvim", opt = false}}
}

lang["chrisbra/csv.vim"] = {opt = true, ft = "csv"}

return lang
