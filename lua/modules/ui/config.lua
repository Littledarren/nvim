local config = {}

function config.catppuccin()
	require("catppuccin").setup({
		transparent_background = false,
		term_colors = true,
		integrations = {
			lsp_trouble = true,
			lsp_saga = true,
			gitsigns = true,
			telescope = true,
			nvimtree = { enabled = true, show_root = true },
			which_key = true,
			indent_blankline = {
				enabled = true,
				colored_indent_levels = false,
			},
			bufferline = true,
			markdown = true,
			lightspeed = false,
			ts_rainbow = true,
			hop = true,
		},
	})
end


function config.indent_blankline()
	require("indent_blankline").setup({
		char = "│",
		show_first_indent_level = true,
		filetype_exclude = {
			"startify",
			"dashboard",
			"dotooagenda",
			"log",
			"fugitive",
			"gitcommit",
			"packer",
			"vimwiki",
			"markdown",
			"json",
			"txt",
			"vista",
			"help",
			"todoist",
			"NvimTree",
			"peekaboo",
			"git",
			"TelescopePrompt",
			"undotree",
			"flutterToolsOutline",
			"", -- for all buffers without a file type
		},
		buftype_exclude = { "terminal", "nofile" },
		show_trailing_blankline_indent = false,
		show_current_context = true,
		context_patterns = {
			"class",
			"function",
			"method",
			"block",
			"list_literal",
			"selector",
			"^if",
			"^table",
			"if_statement",
			"while",
			"for",
			"type",
			"var",
			"import",
		},
		space_char_blankline = " ",
	})
end

function config.alpha()
	local alpha = require("alpha")
	local dashboard = require("alpha.themes.dashboard")
	-- dashboard.section.header.val = {
	-- 	[[                               __                ]],
	-- 	[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
	-- 	[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
	-- 	[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
	-- 	[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
	-- 	[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	-- }
	dashboard.section.buttons.val = {
		dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
		dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
		dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
		dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
		dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
		dashboard.button("c", "  Configuration", ":e ~/.config/nvim/init.lua <CR>"),
		dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
	}

	-- local function footer()
	-- 	return "stghjy@gmail.com"
	-- end
	--
	-- dashboard.section.footer.val = footer()
	--
	-- dashboard.section.footer.opts.hl = "Type"
	-- dashboard.section.header.opts.hl = "Include"
	-- dashboard.section.buttons.opts.hl = "Keyword"
	--
	-- dashboard.opts.opts.noautocmd = true
	-- -- vim.cmd([[autocmd User AlphaReady echo 'ready']])
	alpha.setup(dashboard.opts)
end

return config
