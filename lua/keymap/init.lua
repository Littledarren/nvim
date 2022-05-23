local bind = require("keymap.bind")
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
require("keymap.config")

local plug_map = {
	-- Bufferline
	["n|gb"] = map_cr("BufferLinePick"):with_noremap():with_silent(),
	["n|]b"] = map_cr("BufferLineCycleNext"):with_noremap():with_silent(),
	["n|[b"] = map_cr("BufferLineCyclePrev"):with_noremap():with_silent(),
	["n|<leader>be"] = map_cr("BufferLineSortByExtension"):with_noremap(),
	["n|<leader>bd"] = map_cr("BufferLineSortByDirectory"):with_noremap(),
	["n|<leader>b1"] = map_cr("BufferLineGoToBuffer 1"):with_noremap():with_silent(),
	["n|<leader>b2"] = map_cr("BufferLineGoToBuffer 2"):with_noremap():with_silent(),
	["n|<leader>b3"] = map_cr("BufferLineGoToBuffer 3"):with_noremap():with_silent(),
	["n|<leader>b4"] = map_cr("BufferLineGoToBuffer 4"):with_noremap():with_silent(),
	["n|<leader>b5"] = map_cr("BufferLineGoToBuffer 5"):with_noremap():with_silent(),
	["n|<leader>b6"] = map_cr("BufferLineGoToBuffer 6"):with_noremap():with_silent(),
	["n|<leader>b7"] = map_cr("BufferLineGoToBuffer 7"):with_noremap():with_silent(),
	["n|<leader>b8"] = map_cr("BufferLineGoToBuffer 8"):with_noremap():with_silent(),
	["n|<leader>b9"] = map_cr("BufferLineGoToBuffer 9"):with_noremap():with_silent(),
	-- Packer
	["n|<leader>ps"] = map_cr("PackerSync"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pp"] = map_cr("PackerStatus"):with_silent():with_noremap():with_nowait(),
	["n|<leader>pc"] = map_cr("PackerCompile"):with_silent():with_noremap():with_nowait(),
	-- Lsp map work when insertenter and lsp start
	["n|<leader>lq"] = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
	["n|<leader>li"] = map_cr("LspInstallInfo"):with_noremap():with_silent():with_nowait(),
	["n|<leader>lr"] = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
	-- lsp saga
	["n|<leader>="] = map_cr("lua vim.lsp.buf.formatting()"):with_noremap():with_silent(),
	["v|<leader>="] = map_cr("lua vim.lsp.buf.range_formatting()"):with_noremap():with_silent(),
	["n|g["] = map_cr("Lspsaga diagnostic_jump_prev"):with_noremap():with_silent(),
	["n|g]"] = map_cr("Lspsaga diagnostic_jump_next"):with_noremap():with_silent(),
	["n|<leader>ca"] = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
	["v|<leader>ca"] = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
	["n|gs"] = map_cr("Lspsaga signature_help"):with_noremap():with_silent(),
	["n|<leader>rn"] = map_cr("Lspsaga rename"):with_noremap():with_silent(),
	["n|K"] = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
	["n|<C-u>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(-1)"):with_noremap():with_silent(),
	["n|<C-d>"] = map_cr("lua require('lspsaga.action').smart_scroll_with_saga(1)"):with_noremap():with_silent(),
	["n|gD"] = map_cr("Lspsaga preview_definition"):with_noremap():with_silent(),
	["n|gd"] = map_cr("lua vim.lsp.buf.definition()"):with_noremap():with_silent(),
	["n|gt"] = map_cr("lua vim.lsp.buf.type_definition()"):with_noremap():with_silent(),
	["n|gh"] = map_cr("Lspsaga lsp_finder"):with_noremap():with_silent(),
	["n|gy"] = map_cr("lua vim.lsp.buf.document_symbol()"):with_noremap():with_silent(),
	["n|gI"] = map_cr("lua vim.lsp.buf.implementation()"):with_noremap():with_silent(),
	["n|gl"] = map_cr("Lspsaga show_line_diagnostics"):with_noremap():with_silent(),
	["n|gr"] = map_cr("lua vim.lsp.buf.references()"):with_noremap():with_silent(),
	-- term
	["n|<A-d>"] = map_cr(":ToggleTerm dir=%:p:h"):with_noremap():with_silent(),
	["t|<A-d>"] = map_cu([[<C-\><C-n>:ToggleTerm ]]):with_noremap():with_silent(),
	["t|<esc>"] = map_cu([[<C-\><C-n>]]):with_noremap():with_silent(),
	["n|<A-g>"] = map_cu("Git"):with_noremap():with_silent(),
	["n|gps"] = map_cr("G push"):with_noremap():with_silent(),
	["n|gpl"] = map_cr("G pull"):with_noremap():with_silent(),
	-- Plugin trouble
	["n|<leader>xx"] = map_cr("TroubleToggle"):with_noremap():with_silent(),
	["n|gR"] = map_cr("TroubleToggle lsp_references"):with_noremap():with_silent(),
	["n|<leader>xd"] = map_cr("TroubleToggle document_diagnostics"):with_noremap():with_silent(),
	["n|<leader>xw"] = map_cr("TroubleToggle workspace_diagnostics"):with_noremap():with_silent(),
	["n|<leader>xq"] = map_cr("TroubleToggle quickfix"):with_noremap():with_silent(),
	["n|<leader>xl"] = map_cr("TroubleToggle loclist"):with_noremap():with_silent(),
	["n|<leader>xt"] = map_cr("TodoTrouble"):with_noremap():with_silent(),
	-- Plugin nvim-tree
	["n|<C-n>"] = map_cr("NvimTreeToggle"):with_noremap():with_silent(),
	["n|<Leader>nf"] = map_cr("NvimTreeFindFile"):with_noremap():with_silent(),
	["n|<Leader>nr"] = map_cr("NvimTreeRefresh"):with_noremap():with_silent(),
	-- Plugin Telescope
	["n|<Leader>fa"] = map_cu("Telescope autocommands"):with_noremap():with_silent(),
	["n|<Leader>fb"] = map_cu("Telescope buffers"):with_noremap():with_silent(),
	["n|<Leader>fc"] = map_cu("Telescope colorscheme"):with_noremap():with_silent(),
	["n|<Leader>fd"] = map_cu("Telescope diagnostics"):with_noremap():with_silent(),
	["n|<Leader>fe"] = map_cu("Telescope emoji"):with_noremap():with_silent(),
	["n|<Leader>ff"] = map_cu("Telescope find_files"):with_noremap():with_silent(),
	["n|<Leader>fg"] = map_cu("Telescope git_files"):with_noremap():with_silent(),
	["n|<Leader>fh"] = map_cu("Telescope search_history"):with_noremap():with_silent(),
	["n|<Leader>fj"] = map_cu("Telescope jumplist"):with_noremap():with_silent(),
	["n|<Leader>fk"] = map_cu("Telescope keymaps"):with_noremap():with_silent(),
	["n|<Leader>fl"] = map_cu("Telescope live_grep"):with_noremap():with_silent(),
	["n|<Leader>fm"] = map_cu("Telescope git_commits"):with_noremap():with_silent(),
	["n|<Leader>fn"] = map_cu("Telescope builtin"):with_noremap():with_silent(),
	["n|<Leader>fo"] = map_cu("Telescope oldfiles"):with_noremap():with_silent(),
	["n|<Leader>fp"] = map_cu("lua require('telescope').extensions.project.project{}"):with_noremap():with_silent(),
	["n|<Leader>fq"] = map_cu("Telescope quickfix"):with_noremap():with_silent(),
	["n|<Leader>fr"] = map_cu("lua require('telescope').extensions.frecency.frecency{}"):with_noremap():with_silent(),
	["n|<Leader>fs"] = map_cu("Telescope git_status"):with_noremap():with_silent(),
	["n|<leader>ft"] = map_cr("TodoTelescope"):with_noremap():with_silent(),
	["n|<Leader>fw"] = map_cu("Telescope grep_string"):with_noremap():with_silent(),
	-- Plugin accelerate-jk
	["n|j"] = map_cmd("v:lua.enhance_jk_move('j')"):with_silent():with_expr(),
	["n|k"] = map_cmd("v:lua.enhance_jk_move('k')"):with_silent():with_expr(),
	-- Plugin Hop
	["n|<leader>w"] = map_cu("HopWord"):with_noremap(),
	["n|<leader>j"] = map_cu("HopLine"):with_noremap(),
	["n|<leader>k"] = map_cu("HopLine"):with_noremap(),
	-- Plugin EasyAlign
	["n|ga"] = map_cmd("v:lua.enhance_align('nga')"):with_expr(),
	["x|ga"] = map_cmd("v:lua.enhance_align('xga')"):with_expr(),
	-- Plugin aerial
	["n|<A-t>"] = map_cr("AerialToggle!"):with_noremap():with_silent(),
	-- Plugin lua dev
	["n|<F2>"] = map_cmd("<Plug>(Luadev-RunLine)"):with_silent(),
	["n|<F1>"] = map_cmd("<Plug>(Luadev-Run)"):with_silent(),
	-- Plugin SnipRun
	["n|<F5>"] = map_cr("%SnipRun"):with_noremap():with_silent(),
	["v|<leader>r"] = map_cr("SnipRun"):with_noremap():with_silent(),
	-- Plugin nvim-comment for <c-/> actually
	["i|<c-_>"] = map_cmd("<c-o>:CommentToggle<cr>"):with_noremap():with_silent(),
	["n|<c-_>"] = map_cr("CommentToggle"):with_noremap():with_silent(),
	["v|<c-_>"] = map_cr("'<,'>CommentToggle"):with_noremap():with_silent(),
	-- treesitter object
	["o|m"] = map_cu([[lua require('tsht').nodes()]]):with_silent(),
	["v|m"] = map_cu([[lua require('tsht').nodes()]]):with_silent():with_noremap(),
}

bind.nvim_load_mapping(plug_map)
