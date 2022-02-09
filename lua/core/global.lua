-- 定义了一些全局变量之类的东西
local global = {}

function global:load_variables()
	local os_name = vim.loop.os_uname().sysname
	if os_name == "Windows_NT" then
		assert("do not support shit windows")
	end
	self.is_mac = os_name == "Darwin"
	self.is_linux = os_name == "Linux"
	self.vim_path = vim.fn.stdpath("config")
	local home = os.getenv("HOME")
	self.home = home
	self.modules_dir = self.vim_path .. "/lua/modules"
	self.pack_dir = vim.fn.stdpath("data") .. "/site/"
end

global:load_variables()

return global
