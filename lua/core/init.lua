local global = require("core.global")
local vim = vim

-- Create cache dir and subs dir
local createdir = function()
	local data_dir = {
		global.cache_dir .. "backup",
		global.cache_dir .. "session",
		global.cache_dir .. "swap",
		global.cache_dir .. "tags",
		global.cache_dir .. "undo",
	}
	-- There only check once that If cache_dir exists
	-- Then I don't want to check subs dir exists
	if vim.fn.isdirectory(global.cache_dir) == 0 then
		os.execute("mkdir -p " .. global.cache_dir)
		for _, v in pairs(data_dir) do
			if vim.fn.isdirectory(v) == 0 then
				os.execute("mkdir -p " .. v)
			end
		end
	end
end

-- 禁用默认的插件
local disable_distribution_plugins = function()
	vim.g.loaded_fzf = 1
	vim.g.loaded_gtags = 1
	vim.g.loaded_gzip = 1
	vim.g.loaded_tar = 1
	vim.g.loaded_tarPlugin = 1
	vim.g.loaded_zip = 1
	vim.g.loaded_zipPlugin = 1
	vim.g.loaded_getscript = 1
	vim.g.loaded_getscriptPlugin = 1
	vim.g.loaded_vimball = 1
	vim.g.loaded_vimballPlugin = 1
	vim.g.loaded_matchit = 1
	vim.g.loaded_matchparen = 1
	vim.g.loaded_2html_plugin = 1
	vim.g.loaded_logiPat = 1
	vim.g.loaded_rrhelper = 1
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.loaded_netrwSettings = 1
	vim.g.loaded_netrwFileHandlers = 1
end

local leader_map = function()
	vim.g.mapleader = " "
	vim.cmd([[let maplocalleader=" "]])
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

-- super neovide
local neovide_config = function()
	vim.cmd([[set guifont=JetBrainsMono\ Nerd\ Font:h12]])
	vim.g.neovide_refresh_rate = 60
	vim.g.neovide_cursor_vfx_mode = "railgun"
	vim.g.neovide_no_idle = true
	vim.g.neovide_cursor_animation_length = 0.03
	vim.g.neovide_cursor_trail_length = 0.05
	vim.g.neovide_cursor_antialiasing = true
	vim.g.neovide_cursor_vfx_opacity = 200.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
	vim.g.neovide_cursor_vfx_particle_speed = 20.0
	vim.g.neovide_cursor_vfx_particle_density = 5.0
end

local clipboard_settings = function()
	local isWsl = vim.api.nvim_exec(
		[[
        function! Is_WSL() abort
        let proc_version = '/proc/version'
        echo filereadable(proc_version)
                \  ? !empty(filter(
                \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
                \  : v:false
        endfunction
        call Is_WSL()
        ]],
		true
	)

	if isWsl ~= "0" then
		vim.cmd([[
        let g:clipboard = {
            \   'name': 'win32yank-wsl',
            \   'copy': {
            \      '+': 'win32yank.exe -i --crlf',
            \      '*': 'win32yank.exe -i --crlf',
            \    },
            \   'paste': {
            \      '+': 'win32yank.exe -o --lf',
            \      '*': 'win32yank.exe -o --lf',
            \   },
            \   'cache_enabled': 0,
            \ }

        ]])
	end
end

local load_core = function()
	local pack = require("core.pack")
	createdir()
	disable_distribution_plugins()
	leader_map()

	pack.ensure_plugins()
	-- neovide_config()
	clipboard_settings()

	require("core.options")
	require("core.mapping")
	require("keymap")
	require("core.autocmd")
	pack.load_compile()

	vim.cmd([[colorscheme catppuccin]])
end

load_core()
