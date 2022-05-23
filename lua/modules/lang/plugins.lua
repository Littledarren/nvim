local lang = {}
local conf = require("modules.lang.config")

-- lang["ray-x/go.nvim"] = {
-- 	opt = true,
-- 	ft = "go",
-- 	config = conf.lang_go,
-- }
lang["fatih/vim-go"] = {
	opt = true,
	ft = "go",
	run = ":GoInstallBinaries",
	config = conf.lang_go,
}

lang["lervag/vimtex"] = {
	config = conf.lang_tex,
}

-- lang["rust-lang/rust.vim"] = { opt = true, ft = "rust" }

lang["simrat39/rust-tools.nvim"] = {
	opt = true,
	ft = "rust",
	config = conf.rust_tools,
	requires = { { "nvim-lua/plenary.nvim", opt = false } },
}

lang["chrisbra/csv.vim"] = { opt = true, ft = "csv" }

-- markdown
lang["ekickx/clipboard-image.nvim"] = {
    config = function ()
        require('clipboard-image').setup{
            default = {
                img_dir = {"%:p:h", "assets"},
                img_name = function() return "image-" .. os.date('%Y-%m-%d-%H-%M-%S') end,
                img_dir_txt = "assets"
            }
        }
    end
}

lang["iamcco/markdown-preview.nvim"] = {
	opt = true,
	ft = "markdown",
    run = "cd app && npm install",
	config = function()
		vim.api.nvim_set_keymap("n", "<leader>mp", "<Plug>MarkdownPreview", {})
	end,
}

return lang
