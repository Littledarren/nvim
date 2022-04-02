local fn, uv, api = vim.fn, vim.loop, vim.api
local pack_dir = require("core.global").pack_dir -- 有末尾的 斜杠
local modules_dir = require("core.global").modules_dir -- 没有斜杠
local compile_to_lua = pack_dir .. "lua/packer_compiled.lua"
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_plugins()
	self.repos = {}
	local get_plugins_list = function()
		local list = {}
		local tmp = vim.split(fn.globpath(modules_dir, "*/plugins.lua"), "\n")
		for _, f in ipairs(tmp) do
			list[#list + 1] = f:sub(#modules_dir - 6, -1)
		end
		return list
	end

	local plugins_file = get_plugins_list()
	for _, m in ipairs(plugins_file) do
		local repos = require(m:sub(0, #m - 4))
		for repo, conf in pairs(repos) do
			self.repos[#self.repos + 1] = vim.tbl_extend("force", { repo }, conf)
		end
	end
end

function Packer:load_packer()
	if not packer then
		vim.cmd([[packadd packer.nvim]])
		packer = require("packer")
	end
	packer.init({
		compile_path = compile_to_lua,
		--  packer_compiled,
		disable_commands = true,
		max_jobs = 10,
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
		git = {
			default_url_format = "https://github.com/%s",
		},
	})
	packer.reset()
	local use = packer.use
	self:load_plugins()
	use({ "wbthomason/packer.nvim", opt = true })
	for _, repo in ipairs(self.repos) do
		use(repo)
	end
end

function Packer:init_ensure_plugins()
	local packer_dir = pack_dir .. "pack/packer/opt/packer.nvim"
	local state = uv.fs_stat(packer_dir)
	if not state then
		local cmd = "!git clone https://github.com/wbthomason/packer.nvim " .. packer_dir
		api.nvim_command(cmd)
		uv.fs_mkdir(pack_dir .. "lua", 511, function()
			assert("make compile path dir faield")
		end)
		self:load_packer()
		packer.install()
	end
end

local plugins = setmetatable({}, {
	__index = function(_, key)
		if not packer then
			Packer:load_packer()
		end
		return packer[key]
	end,
})

function plugins.ensure_plugins()
	Packer:init_ensure_plugins()
end

function plugins.auto_compile()
	local file = vim.fn.expand("%:p")
	if file:match(modules_dir) then
		plugins.clean()
		plugins.compile()
	end
end

function plugins.load_compile()
	if vim.fn.filereadable(compile_to_lua) == 1 then
		assert(pcall(require, "packer_compiled"), "loading packer_compiled failed! Try run :PackerSync! ")
	else
		plugins.compile()
		assert(pcall(require, "packer_compiled"), "loading packer_compiled failed! Try run :PackerSync! ")
	end
	vim.cmd([[command! PackerCompile lua require('core.pack').compile()]])
	vim.cmd([[command! PackerInstall lua require('core.pack').install()]])
	vim.cmd([[command! PackerUpdate lua require('core.pack').update()]])
	vim.cmd([[command! PackerSync lua require('core.pack').sync()]])
	vim.cmd([[command! PackerClean lua require('core.pack').clean()]])
	vim.cmd([[command! PackerStatus lua require('core.pack').status()]])
	vim.cmd([[autocmd User PackerComplete lua require('core.pack').compile()]])
end

return plugins
