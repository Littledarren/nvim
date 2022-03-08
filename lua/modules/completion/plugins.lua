local completion = {}
local conf = require("modules.completion.config")

completion["neovim/nvim-lspconfig"] = {
	opt = true,
	event = "BufReadPre",
	config = conf.nvim_lsp,
}
completion["williamboman/nvim-lsp-installer"] = {
	opt = true,
	after = "nvim-lspconfig",
}
completion["RishabhRD/nvim-lsputils"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.nvim_lsputils,
}
-- lsp ui
completion["tami5/lspsaga.nvim"] = { opt = true, after = "nvim-lspconfig" }
-- show a 💡
completion["kosayoda/nvim-lightbulb"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.lightbulb,
}
-- 展示函数签名
completion["ray-x/lsp_signature.nvim"] = { opt = true, after = "nvim-lspconfig" }
-- 补全
completion["hrsh7th/nvim-cmp"] = {
	config = conf.cmp,
	event = "InsertEnter",
	requires = {
		{ "lukas-reineke/cmp-under-comparator" },
		{ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lua", after = "cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path", after = "cmp-tmux" },
		{ "hrsh7th/cmp-buffer", after = "cmp-spell" },
		{ "hrsh7th/cmp-emoji", after = "cmp-spell" },
		{ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" },
		{ "andersevenrud/cmp-tmux", after = "cmp-nvim-lua" },
		{ "f3fora/cmp-spell", after = "cmp-path" },
		{ "kdheepak/cmp-latex-symbols", after = "cmp-buffer" },
	},
}
completion["jose-elias-alvarez/null-ls.nvim"] = {
	opt = true,
	after = "nvim-lspconfig",
	config = conf.nullls,
}
completion["L3MON4D3/LuaSnip"] = {
	after = "nvim-cmp",
	config = conf.luasnip,
	requires = { "rafamadriz/friendly-snippets" },
}
completion["windwp/nvim-autopairs"] = {
	after = "nvim-cmp",
	config = conf.autopairs,
}

return completion
