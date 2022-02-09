vim.cmd([[packadd nvim-lsp-installer]])
vim.cmd([[packadd lsp_signature.nvim]])
vim.cmd([[packadd lspsaga.nvim]])
vim.cmd([[packadd cmp-nvim-lsp]])

local nvim_lsp = require("lspconfig")
local saga = require("lspsaga")
local lsp_installer = require("nvim-lsp-installer")

-- Override diagnostics symbol

saga.init_lsp_saga({
	error_sign = "",
	warn_sign = "",
	hint_sign = "",
	infor_sign = "",
})

lsp_installer.settings({
	ui = {
		icons = {
			server_installed = "✓",
			server_pending = "➜",
			server_uninstalled = "✗",
		},
	},
})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Override default format setting
local function custom_attach(client)
	require("lsp_signature").on_attach({
		bind = true,
		use_lspsaga = false,
		floating_window = true,
		fix_pos = true,
		hint_enable = true,
		hi_parameter = "Search",
		handler_opts = { "double" },
	})

	if client.resolved_capabilities.document_highlight then
		vim.cmd([[
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
            augroup END
        ]])
	end
end

local function switch_source_header_splitcmd(bufnr, splitcmd)
	bufnr = nvim_lsp.util.validate_bufnr(bufnr)
	local params = { uri = vim.uri_from_bufnr(bufnr) }
	vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", params, function(err, result)
		if err then
			error(tostring(err))
		end
		if not result then
			print("Corresponding file can’t be determined")
			return
		end
		vim.api.nvim_command(splitcmd .. " " .. vim.uri_to_fname(result))
	end)
end

-- Override server settings here
local enhance_server_opts = {
	["sumneko_lua"] = function(opts)
		opts.settings = {
			Lua = {
				diagnostics = { globals = { "vim" } },
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
					},
					maxPreload = 100000,
					preloadFileSize = 10000,
				},
				telemetry = { enable = false },
			},
		}
	end,
	["clangd"] = function(opts)
		opts.args = {
			"--background-index",
			"-std=c++20",
			"--pch-storage=memory",
			"--clang-tidy",
			"--suggest-missing-includes",
		}
		opts.capabilities.offsetEncoding = { "utf-16" }
		opts.single_file_support = true
		opts.commands = {
			ClangdSwitchSourceHeader = {
				function()
					switch_source_header_splitcmd(0, "edit")
				end,
				description = "Open source/header in current buffer",
			},
			ClangdSwitchSourceHeaderVSplit = {
				function()
					switch_source_header_splitcmd(0, "vsplit")
				end,
				description = "Open source/header in a new vsplit",
			},
			ClangdSwitchSourceHeaderSplit = {
				function()
					switch_source_header_splitcmd(0, "split")
				end,
				description = "Open source/header in a new split",
			},
		}
		-- Disable `clangd`'s format
		opts.on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			custom_attach(client)
		end
	end,
	["jsonls"] = function(opts)
		opts.settings = {
			json = {
				-- Schemas https://www.schemastore.org
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig*.json" },
						url = "https://json.schemastore.org/tsconfig.json",
					},
					{
						fileMatch = {
							".prettierrc",
							".prettierrc.json",
							"prettier.config.json",
						},
						url = "https://json.schemastore.org/prettierrc.json",
					},
					{
						fileMatch = { ".eslintrc", ".eslintrc.json" },
						url = "https://json.schemastore.org/eslintrc.json",
					},
					{
						fileMatch = {
							".babelrc",
							".babelrc.json",
							"babel.config.json",
						},
						url = "https://json.schemastore.org/babelrc.json",
					},
					{
						fileMatch = { "lerna.json" },
						url = "https://json.schemastore.org/lerna.json",
					},
					{
						fileMatch = {
							".stylelintrc",
							".stylelintrc.json",
							"stylelint.config.json",
						},
						url = "http://json.schemastore.org/stylelintrc.json",
					},
					{
						fileMatch = { "/.github/workflows/*" },
						url = "https://json.schemastore.org/github-workflow.json",
					},
				},
			},
		}
	end,
	["tsserver"] = function(opts)
		-- Disable `tsserver`'s format
		opts.on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			custom_attach(client)
		end
	end,
	["dockerls"] = function(opts)
		-- Disable `dockerls`'s format
		opts.on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			custom_attach(client)
		end
	end,
	["gopls"] = function(opts)
		opts.cmd = { "gopls", "-remote=auto" }
		opts.settings = {
			gopls = {
				usePlaceholders = true,
				analyses = {
					nilness = true,
					shadow = true,
					unusedparams = true,
					unusewrites = true,
				},
				staticcheck = true,
			},
		}
		-- Disable `gopls`'s format
		opts.on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			custom_attach(client)
		end
	end,
	["texlab"] = function(opts)
		-- Disable `texlab`'s format
		opts.on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			custom_attach(client)
		end
	end,
	["html"] = function(opts)
		opts.cmd = { "html-languageserver", "--stdio" }
		opts.filetypes = { "html" }
		opts.init_options = {
			configurationSection = { "html", "css", "javascript" },
			embeddedLanguages = { css = true, javascript = true },
		}
		opts.settings = {}
		opts.single_file_support = true
	end,
	["ltex"] = function(opts)
		opts.settings = {
			ltex = {
				additionalRules = {
					motherTongue = "zh-CN",
				},
				language = "zh-CN",
			},
		}
	end,
}

lsp_installer.on_server_ready(function(server)
	local opts = {
		capabilities = capabilities,
		flags = { debounce_text_changes = 500 },
		on_attach = custom_attach,
	}

	if enhance_server_opts[server.name] then
		enhance_server_opts[server.name](opts)
	end

	server:setup(opts)
end)
