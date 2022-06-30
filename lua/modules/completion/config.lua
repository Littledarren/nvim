local config = {}

function config.nvim_lsp()
	require("modules.completion.lsp")
end

function config.lightbulb()
	vim.cmd([[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]])
end

function config.cmp()
	vim.cmd([[highlight CmpItemAbbrDeprecated guifg=#D8DEE9 guibg=NONE gui=strikethrough]])
	vim.cmd([[highlight CmpItemKindSnippet guifg=#BF616A guibg=NONE]])
	vim.cmd([[highlight CmpItemKindUnit guifg=#D08770 guibg=NONE]])
	vim.cmd([[highlight CmpItemKindProperty guifg=#A3BE8C guibg=NONE]])
	vim.cmd([[highlight CmpItemKindKeyword guifg=#EBCB8B guibg=NONE]])
	vim.cmd([[highlight CmpItemAbbrMatch guifg=#5E81AC guibg=NONE]])
	vim.cmd([[highlight CmpItemAbbrMatchFuzzy guifg=#5E81AC guibg=NONE]])
	vim.cmd([[highlight CmpItemKindVariable guifg=#8FBCBB guibg=NONE]])
	vim.cmd([[highlight CmpItemKindInterface guifg=#88C0D0 guibg=NONE]])
	vim.cmd([[highlight CmpItemKindText guifg=#81A1C1 guibg=NONE]])
	vim.cmd([[highlight CmpItemKindFunction guifg=#B48EAD guibg=NONE]])
	vim.cmd([[highlight CmpItemKindMethod guifg=#B48EAD guibg=NONE]])

	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end
	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	local cmp = require("cmp")
	cmp.setup({
		sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				require("cmp-under-comparator").under,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
		},
		formatting = {
			format = function(entry, vim_item)
				local lspkind_icons = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "",
					Event = "",
					Operator = "",
					TypeParameter = "",
				}
				-- load lspkind icons
				vim_item.kind = string.format("%s %s", lspkind_icons[vim_item.kind], vim_item.kind)

				vim_item.menu = ({
					-- cmp_tabnine = "[TN]",
					nvim_lsp = "[LSP]",
					buffer = "[BUF]",
					-- orgmode = "[ORG]",
					path = "[PATH]",
					nvim_lua = "[LUA]",
					tmux = "[TMUX]",
					luasnip = "[SNIP]",
					spell = "[SPELL]",
					latex_symbols = "[LATEX]",
				})[entry.source.name]

				return vim_item
			end,
		},
		-- You can set mappings if you want
		mapping = {
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-e>"] = cmp.mapping.close(),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-h>"] = cmp.mapping(function(fallback)
				if require("luasnip").jumpable(-1) then
					vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
				else
					fallback()
				end
			end, { "i", "s" }),
			["<C-l>"] = cmp.mapping(function(fallback)
				if require("luasnip").expand_or_jumpable() then
					vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
				else
					fallback()
				end
			end, { "i", "s" }),
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		-- You should specify your *installed* sources.
		sources = {
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{
				name = "buffer",
				option = {
					get_bufnrs = function()
						return vim.api.nvim_list_bufs()
					end,
				},
			},
			{ name = "path" },
			{ name = "latex_symbols" },
			{ name = "emoji" },
			{ name = "nvim_lua" },
			{ name = "tmux" },
			{ name = "spell" },
			-- {name = 'cmp_tabnine'}
		},
	})
end

function config.luasnip()
	local ls = require("luasnip")

	local types = require("luasnip.util.types")
	ls.config.setup({
		ext_opts = {
			[types.choiceNode] = {
				active = {
					virt_text = { { "●", "DiagnosticWarn" } },
					priority = 0,
				},
			},
		},
		history = true,
		-- updateevents = "TextChanged,TextChangedI",
		updateevents = "InsertLeave",
		region_check_events = "CursorHold,InsertLeave",
		delete_check_events = "TextChanged,InsertEnter",
		snip_env = {
			s = ls.s,
			sn = ls.sn,
			t = ls.t,
			i = ls.i,
			f = function(func, argnodes, ...)
				return ls.f(function(args, imm_parent, user_args)
					return func(args, imm_parent.snippet, user_args)
				end, argnodes, ...)
			end,
			-- override to enable restore_cursor.
			c = function(pos, nodes, opts)
				opts = opts or {}
				opts.restore_cursor = true
				return ls.c(pos, nodes, opts)
			end,
			d = function(pos, func, argnodes, ...)
				return ls.d(pos, function(args, imm_parent, old_state, ...)
					return func(args, imm_parent.snippet, old_state, ...)
				end, argnodes, ...)
			end,
			isn = require("luasnip.nodes.snippet").ISN,
			l = require("luasnip.extras").lambda,
			dl = require("luasnip.extras").dynamic_lambda,
			rep = require("luasnip.extras").rep,
			r = ls.restore_node,
			p = require("luasnip.extras").partial,
			types = require("luasnip.util.types"),
			events = require("luasnip.util.events"),
			util = require("luasnip.util.util"),
			fmt = require("luasnip.extras.fmt").fmt,
			fmta = require("luasnip.extras.fmt").fmta,
			ls = ls,
			ins_generate = function(nodes)
				return setmetatable(nodes or {}, {
					__index = function(table, key)
						local indx = tonumber(key)
						if indx then
							local val = ls.i(indx)
							rawset(table, key, val)
							return val
						end
					end,
				})
			end,
			parse = ls.parser.parse_snippet,
			n = require("luasnip.extras").nonempty,
			m = require("luasnip.extras").match,
			ai = require("luasnip.nodes.absolute_indexer"),
		},
	})
	vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
	vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
	vim.api.nvim_set_keymap("i", "<C-t>", "<Plug>luasnip-prev-choice", {})
	vim.api.nvim_set_keymap("s", "<C-t>", "<Plug>luasnip-prev-choice", {})
	vim.cmd([[ 
        command! LuaSnipEdit lua require('luasnip.loaders.from_lua').edit_snippet_files()
    ]])

	require("luasnip.loaders.from_lua").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./my-snippets" } })
end

function config.autopairs()
	require("nvim-autopairs").setup({
		disable_filetype = { "TelescopePrompt" },
		fast_wrap = {},
		disable_in_macro = true, -- disable when recording or executing a macro
		disable_in_visualblock = true, -- disable when insert after visual block mode
		check_ts = true,
	})
	-- If you want insert `(` after select function or method item
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")
	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
end

function config.nvim_lsputils()
	vim.lsp.handlers["textDocument/codeAction"] = require("lsputil.codeAction").code_action_handler
	vim.lsp.handlers["textDocument/references"] = require("lsputil.locations").references_handler
	vim.lsp.handlers["textDocument/definition"] = require("lsputil.locations").definition_handler
	vim.lsp.handlers["textDocument/declaration"] = require("lsputil.locations").declaration_handler
	vim.lsp.handlers["textDocument/typeDefinition"] = require("lsputil.locations").typeDefinition_handler
	vim.lsp.handlers["textDocument/implementation"] = require("lsputil.locations").implementation_handler
	vim.lsp.handlers["textDocument/documentSymbol"] = require("lsputil.symbols").document_handler
	vim.lsp.handlers["workspace/symbol"] = require("lsputil.symbols").workspace_handler
end

function config.nullls()
	local ls = require("null-ls")
	local formatting = ls.builtins.formatting
	local diagnostics = ls.builtins.diagnostics
	-- local completion = ls.builtins.completion
	local code_actions = ls.builtins.code_actions
	local sources = {
		formatting.stylua,
		formatting.clang_format,
		formatting.buf,
		formatting.latexindent,
		formatting.prettier.with({
			disabled_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		}),
		formatting.eslint_d,
		formatting.shfmt,
		formatting.black,
		formatting.gofumpt.with({
			args = { "-extra" },
		}),
		formatting.goimports,

		diagnostics.eslint_d,
		diagnostics.buf,
		diagnostics.shellcheck,
		diagnostics.codespell,

		code_actions.eslint_d,
		-- code_actions.gitsigns,
		code_actions.shellcheck,

		-- completion.spell,
	}
	ls.setup({
		sources = sources,
		on_attach = function(client)
			if client.server_capabilities.documentFormattingProvider then
				vim.cmd([[
                augroup Null_Format
                    autocmd! * <buffer>
                    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 5000)
                augroup END
                ]])
			end
		end,
	})
end

return config
