local config = {}

function config.rust_tools()
	local opts = {
		tools = {
			-- rust-tools options
			-- Automatically set inlay hints (type hints)
			autoSetHints = true,
			-- Whether to show hover actions inside the hover window
			-- This overrides the default hover handler
			hover_with_actions = true,
			runnables = {
				-- whether to use telescope for selection menu or not
				use_telescope = true,

				-- rest of the opts are forwarded to telescope
			},
			debuggables = {
				-- whether to use telescope for selection menu or not
				use_telescope = true,

				-- rest of the opts are forwarded to telescope
			},
			-- These apply to the default RustSetInlayHints command
			inlay_hints = {
				-- Only show inlay hints for the current line
				only_current_line = false,
				-- Event which triggers a refersh of the inlay hints.
				-- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
				-- not that this may cause  higher CPU usage.
				-- This option is only respected when only_current_line and
				-- autoSetHints both are true.
				only_current_line_autocmd = "CursorHold",
				-- wheater to show parameter hints with the inlay hints or not
				show_parameter_hints = true,
				-- prefix for parameter hints
				parameter_hints_prefix = "<- ",
				-- prefix for all the other hints (type, chaining)
				other_hints_prefix = " » ",
				-- whether to align to the length of the longest line in the file
				max_len_align = false,
				-- padding from the left if max_len_align is true
				max_len_align_padding = 1,
				-- whether to align to the extreme right or not
				right_align = false,
				-- padding from the right if right_align is true
				right_align_padding = 7,
			},
			hover_actions = {
				-- the border that is used for the hover window
				-- see vim.api.nvim_open_win()
				border = {
					{ "╭", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╮", "FloatBorder" },
					{ "│", "FloatBorder" },
					{ "╯", "FloatBorder" },
					{ "─", "FloatBorder" },
					{ "╰", "FloatBorder" },
					{ "│", "FloatBorder" },
				},
				-- whether the hover action window gets automatically focused
				auto_focus = false,
			},
		},
		-- all the opts to send to nvim-lspconfig
		-- these override the defaults set by rust-tools.nvim
		-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
		server = {}, -- rust-analyer options
	}

	require("rust-tools").setup(opts)
end

function config.lang_go()
	-- require("go").setup()
	vim.cmd([[
	        let g:go_def_mapping_enabled = 0 " 取消默认的gd映射
	        let g:go_doc_keywordprg_enabled = 0 "取消默认K映射
	        let g:go_autodetect_gopath = 1
	        let g:go_fmt_autosave = 0 " 禁用默认的格式化工具
	        "let g:go_list_type = "loc"
	        let g:go_metalinter_command = 'golangci-lint'
	        let g:go_version_warning = 1
	        let g:godef_split=2
    ]])
	local bind = require("keymap.bind")
	local map_cr = bind.map_cr
	-- vim-go
	local go_map = {
		["n|<leader>gau"] = map_cr("GoAddTest"):with_silent(),
		["n|<leader>gat"] = map_cr("GoAddTag"):with_silent(),
		["n|<leader>gb"] = map_cr("GoBuild"):with_silent(),
		["n|<leader>gc"] = map_cr("GoCoverageToggle"):with_silent(),
		["n|<leader>gd"] = map_cr("GoDoc"):with_silent(),
		["n|<leader>ge"] = map_cr("GoIfErr"):with_silent(),
		["n|<leader>gf"] = map_cr("GoFmt"):with_silent(),
		["n|<leader>gg"] = map_cr("GoGenerate"):with_silent(),
		["n|<leader>gi"] = map_cr("GoImpl"):with_silent(),
		["n|<leader>gl"] = map_cr("GoLint"):with_silent(),
		["n|<leader>gm"] = map_cr("GoMetaLinter"):with_silent(),
		["n|<leader>gh"] = map_cr("GoAlternate!"):with_silent(),
		["n|<leader>gr"] = map_cr("GoRename"):with_silent(),
		["n|<leader>gtf"] = map_cr("GoTestFunc"):with_silent(),
		["n|<leader>gtp"] = map_cr("GoTest"):with_silent(),
	}
	bind.nvim_load_mapping(go_map)
end

function config.lang_tex()
	vim.cmd([[
    let g:tex_lavor='latex'
    let g:vimtex_complete_enabled = 0
    let g:vimtex_texcount_custom_arg=' -ch -total'
    au FileType tex map <buffer> <silent>  <leader>lw :VimtexCountWords!  <CR><CR>
    let g:vimtex_compiler_latexmk_engines = {
            \ '_'                : '-pdf',
            \ 'pdflatex'         : '-pdf',
            \ 'dvipdfex'         : '-pdfdvi',
            \ 'lualatex'         : '-lualatex',
            \ 'xelatex'          : '-xelatex',
            \ 'context (pdftex)' : '-pdf -pdflatex=texexec',
            \ 'context (luatex)' : '-pdf -pdflatex=context',
            \ 'context (xetex)'  : '-pdf -pdflatex=''texexec --xtx''',
            \}
    let g:vimtex_compiler_latexmk = {
            \ 'build_dir' : '',
            \ 'callback' : 1,
            \ 'continuous' : 1,
            \ 'executable' : 'latexmk',
            \ 'hooks' : [],
            \ 'options' : [
                \   '-verbose',
                \   '-file-line-error',
                \   '-shell-escape',
                \   '-synctex=1',
                \   '-interaction=nonstopmode',
                \ ],
                \}
    let g:vimtex_quickfix_mode = 0
    let g:vimtex_view_general_viewer = 'zathura'
    let g:vimtex_view_method = 'zathura'

    function! CloseViewers()
        " Close viewers on quit
        if executable('xdotool') && exists('b:vimtex')
                    \ && exists('b:vimtex.viewer') && b:vimtex.viewer.xwin_id > 0
            call system('xdotool windowclose '. b:vimtex.viewer.xwin_id)
        endif
    endfunction

    augroup vimtex_event_1
        au!
        au User VimtexEventQuit     VimtexClean
        au User VimtexEventQuit call CloseViewers()
    augroup END
    ]])
end

return config
