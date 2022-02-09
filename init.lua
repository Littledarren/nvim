if not vim.g.vscode then
	local ok = pcall(require, "impatient")
	if not ok then
		vim.notify("impatient is not loaded correctly")
	end
	require("core")
end
