_G.luasnip = {}
_G.luasnip.vars = {
	username = "syncrack",
	email = "stghjy@gmail.com",
	github = "https://github.com/littledarren",
	real_name = "Junyi Huang",
}

local get_cstring = function()
	local cstring = vim.o.commentstring
	-- as we want only the strings themselves and not strings ready for using `format` we want to split the beginning and end
	local cstring_table = vim.split(cstring, "%s", { plain = true, trimempty = true })
	if #cstring_table == 0 then
		return { "", "" } -- default
	end
	return #cstring_table == 1 and { cstring_table[1], "" } or { cstring_table[1], cstring_table[2] }
end
local marks = {
	signature = function()
		return fmt("<{}>", i(1, _G.luasnip.vars.username))
	end,
	signature_with_email = function()
		return fmt("<{}{}>", { i(1, _G.luasnip.vars.username), i(2, " " .. _G.luasnip.vars.email) })
	end,
	date_signature_with_email = function()
		return fmt(
			"<{}{}{}>",
			{ i(1, os.date("%d-%m-%y")), i(2, ", " .. _G.luasnip.vars.username), i(3, " " .. _G.luasnip.vars.email) }
		)
	end,
	date_signature = function()
		return fmt("<{}{}>", { i(1, os.date("%d-%m-%y")), i(2, ", " .. _G.luasnip.vars.username) })
	end,
	date = function()
		return fmt("<{}>", i(1, os.date("%d-%m-%y")))
	end,
	empty = function()
		return t("")
	end,
}
local todo_snippet_nodes = function(aliases)
	local aliases_nodes = vim.tbl_map(function(alias)
		return i(nil, alias) -- generate choices for [name-of-comment]
	end, aliases)
	local sigmark_nodes = {} -- choices for [comment-mark]
	for _, mark in pairs(marks) do
		table.insert(sigmark_nodes, mark())
	end
	-- format them into the actual snippet
	local comment_node = fmta("<> <>: <> <> <><>", {
		f(function()
			return get_cstring()[1] -- get <comment-string[1]>
		end),
		c(1, aliases_nodes), -- [name-of-comment]
		i(3), -- {comment-text}
		c(2, sigmark_nodes), -- [comment-mark]
		f(function()
			return get_cstring()[2] -- get <comment-string[2]>
		end),
		i(0),
	})
	return comment_node
end

--- Generate a TODO comment snippet with an automatic description and docstring
---@param context table merged with the generated context table `trig` must be specified
---@param aliases string[]|string of aliases for the todo comment (ex.: {FIX, ISSUE, FIXIT, BUG})
local todo_snippet = function(context, aliases)
	aliases = type(aliases) == "string" and { aliases } or aliases -- if we do not have aliases, be smart about the function parameters
	context = context or {}
	if not context.trig then
		return error("context doesn't include a `trig` key which is mandatory", 2) -- all we need from the context is the trigger
	end
	local alias_string = table.concat(aliases, "|") -- `choice_node` documentation
	context.name = context.name or (alias_string .. " comment") -- generate the `name` of the snippet if not defined
	context.dscr = context.dscr or (alias_string .. " comment with a signature-mark") -- generate the `dscr` if not defined
	context.docstring = context.docstring or (" {1:" .. alias_string .. "}: {3} <{2:mark}>{0} ") -- generate the `docstring` if not defined
	local comment_node = todo_snippet_nodes(aliases) -- nodes from the previously defined function for their generation
	return s(context, comment_node) -- the final todo-snippet constructed from our parameters
end
local todo_snippet_specs = {
	{ { trig = "todo" }, "TODO" },
	{ { trig = "fix" }, { "FIX", "BUG", "ISSUE", "FIXIT" } },
	{ { trig = "hack" }, "HACK" },
	{ { trig = "warn" }, { "WARN", "WARNING", "XXX" } },
	{ { trig = "perf" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
	{ { trig = "note" }, { "NOTE", "INFO" } },
}

local todo_comment_snippets = {}
for _, v in ipairs(todo_snippet_specs) do
	table.insert(todo_comment_snippets, todo_snippet(v[1], v[2]))
end
local function bash(_, _, command)
	local file = io.popen(command, "r")
	local res = {}
	for line in file:lines() do
		table.insert(res, line)
	end
	return res
end

return vim.list_extend(todo_comment_snippets, {
	s("date", p(os.date, "%Y-%m-%d")),
})
