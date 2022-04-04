if not vim.g.vscode then
	------------------------
	-- impatient me! 😎
	------------------------
	local ok = pcall(require, "impatient")
	if not ok then
		vim.notify("impatient is not loaded correctly")
	end
	----------
	-- core
	----------
	require("core")
end
