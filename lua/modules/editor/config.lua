local config = {}
local dap_dir = vim.fn.stdpath("data") .. "/dapinstall/"
local sessions_dir = vim.fn.stdpath("data") .. "/sessions/"

function config.aerial()
	require("aerial").setup({})
end

function config.nvim_treesitter()
	vim.api.nvim_command("set foldmethod=expr")
	vim.api.nvim_command("set foldexpr=nvim_treesitter#foldexpr()")

	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"c",
			"cpp",
			"vue",
			"bash",
			"latex",
			"bibtex",
			"java",
			"gomod",
			"yaml",
			"javascript",
			"dockerfile",
			"html",
			"make",
			"lua",
			"rust",
			"python",
			"go",
			"markdown_inline",
			"json",
			"markdown",
			"proto",
			"typescript",
		},
		highlight = { enable = true, disable = { "vim", "latex" } },
		playground = {
			enable = true,
			disable = {},
			updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
			persist_queries = false, -- Whether the query persists across vim sessions
			keybindings = {
				toggle_query_editor = "o",
				toggle_hl_groups = "i",
				toggle_injected_languages = "t",
				toggle_anonymous_nodes = "a",
				toggle_language_display = "I",
				focus_language = "f",
				unfocus_language = "F",
				update = "R",
				goto_node = "<cr>",
				show_help = "?",
			},
		},
		textobjects = {
			select = {
				enable = true,
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
				},
			},
			move = {
				enable = true,
				set_jumps = true, -- whether to set jumps in the jumplist
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_next_end = {
					["]M"] = "@function.outer",
					["]["] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				goto_previous_end = {
					["[M"] = "@function.outer",
					["[]"] = "@class.outer",
				},
			},
		},
		rainbow = {
			enable = true,
			extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
			max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
		},
		context_commentstring = { enable = true, enable_autocmd = false },
		matchup = { enable = true },
		context = { enable = true, throttle = true },
	})
end

function config.matchup()
	vim.cmd([[let g:matchup_matchparen_offscreen = {'method': 'popup'}]])
end

function config.autotag()
	require("nvim-ts-autotag").setup({
		filetypes = {
			"html",
			"xml",
			"javascript",
			"typescriptreact",
			"javascriptreact",
			"vue",
		},
	})
end

function config.nvim_colorizer()
	require("colorizer").setup()
end

function config.neoscroll()
	require("neoscroll").setup({
		-- All these keys will be mapped to their corresponding default scrolling animation
		mappings = {
			"<C-u>",
			"<C-d>",
			"<C-b>",
			"<C-f>",
			"<C-y>",
			"<C-e>",
			"zt",
			"zz",
			"zb",
		},
		hide_cursor = true, -- Hide cursor while scrolling
		stop_eof = true, -- Stop at <EOF> when scrolling downwards
		use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
		respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
		cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
		easing_function = nil, -- Default easing function
		pre_hook = nil, -- Function to run before the scrolling animation starts
		post_hook = nil, -- Function to run after the scrolling animation ends
	})
end

function config.toggleterm()
	require("toggleterm").setup({
		-- size can be a number or function which is passed the current terminal
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.40
			end
		end,
		open_mapping = [[<c-\>]],
		hide_numbers = true, -- hide the number column in toggleterm buffers
		shade_filetypes = {},
		shade_terminals = true,
		shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
		start_in_insert = true,
		insert_mappings = true, -- whether or not the open mapping applies in insert mode
		persist_size = true,
		direction = "float",
		close_on_exit = true, -- close the terminal window when the process exits
	})
end

function config.lualine()
	local symbols_outline = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "filetype" },
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = { "location" },
		},
		filetypes = { "Outline" },
	}

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = "onedark",
			disabled_filetypes = {},
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "branch" }, { "diff" } },
			lualine_c = {
				{ "lsp_progress" },
			},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					symbols = { error = " ", warn = " ", info = " " },
				},
			},
			lualine_y = { "filetype", "encoding", "fileformat" },
			lualine_z = { "progress", "location" },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { "filename" },
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		extensions = {
			"quickfix",
			"nvim-tree",
			"toggleterm",
			"fugitive",
			symbols_outline,
		},
	})
end

function config.nvim_tree()
	require("nvim-tree").setup({})
end

function config.nvim_bufferline()
	require("bufferline").setup({
		options = {
			number = "none",
			modified_icon = "✥",
			buffer_close_icon = "",
			left_trunc_marker = "",
			right_trunc_marker = "",
			max_name_length = 14,
			max_prefix_length = 13,
			tab_size = 20,
			show_buffer_close_icons = true,
			show_buffer_icons = true,
			show_tab_indicators = true,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			separator_style = "thin",
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					padding = 1,
				},
			},
		},
	})
end

function config.gitsigns()
	require("gitsigns").setup({
		signs = {
			add = {
				hl = "GitSignsAdd",
				text = "│",
				numhl = "GitSignsAddNr",
				linehl = "GitSignsAddLn",
			},
			change = {
				hl = "GitSignsChange",
				text = "│",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
			delete = {
				hl = "GitSignsDelete",
				text = "_",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			topdelete = {
				hl = "GitSignsDelete",
				text = "‾",
				numhl = "GitSignsDeleteNr",
				linehl = "GitSignsDeleteLn",
			},
			changedelete = {
				hl = "GitSignsChange",
				text = "~",
				numhl = "GitSignsChangeNr",
				linehl = "GitSignsChangeLn",
			},
		},
		keymaps = {
			-- Default keymap options
			noremap = true,
			buffer = true,
			["n ]g"] = {
				expr = true,
				"&diff ? ']g' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'",
			},
			["n [g"] = {
				expr = true,
				"&diff ? '[g' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'",
			},
			["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
			["v <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
			["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
			["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
			["v <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
			["n <leader>hR"] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
			["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
			["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line{full=true}<CR>',
			-- Text objects
			["o ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
			["x ih"] = ':<C-U>lua require"gitsigns".text_object()<CR>',
		},
		watch_gitdir = { interval = 1000, follow_files = true },
		current_line_blame = true,
		current_line_blame_opts = { delay = 1000, virtual_text_pos = "eol" },
		sign_priority = 6,
		update_debounce = 100,
		status_formatter = nil, -- Use default
		word_diff = false,
		diff_opts = { internal = true },
	})
end

function config.trouble()
	require("trouble").setup({
		position = "bottom", -- position of the list can be: bottom, top, left, right
		height = 10, -- height of the trouble list when position is top or bottom
		width = 50, -- width of the list when position is left or right
		icons = true, -- use devicons for filenames
		mode = "document_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
		fold_open = "", -- icon used for open folds
		fold_closed = "", -- icon used for closed folds
		action_keys = {
			-- key mappings for actions in the trouble list
			-- map to {} to remove a mapping, for example:
			-- close = {},
			close = "q", -- close the list
			cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
			refresh = "r", -- manually refresh
			jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
			open_split = { "<c-x>" }, -- open buffer in new split
			open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
			open_tab = { "<c-t>" }, -- open buffer in new tab
			jump_close = { "o" }, -- jump to the diagnostic and close the list
			toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
			toggle_preview = "P", -- toggle auto_preview
			hover = "K", -- opens a small popup with the full multiline message
			preview = "p", -- preview the diagnostic location
			close_folds = { "zM", "zm" }, -- close all folds
			open_folds = { "zR", "zr" }, -- open all folds
			toggle_fold = { "zA", "za" }, -- toggle fold of current file
			previous = "k", -- preview item
			next = "j", -- next item
		},
		indent_lines = true, -- add an indent guide below the fold icons
		auto_open = false, -- automatically open the list when you have diagnostics
		auto_close = false, -- automatically close the list when you have no diagnostics
		auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
		auto_fold = false, -- automatically fold a file trouble list at creation
		signs = {
			-- icons / text used for a diagnostic
			error = "",
			warning = "",
			hint = "",
			information = "",
			other = "﫠",
		},
		use_lsp_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
	})
end

return config
