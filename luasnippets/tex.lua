local rec_ls
rec_ls = function()
	return sn(nil, {
		c(1, {
			-- important!! Having the sn(...) as the first choice will cause infinite recursion.
			t({ "" }),
			-- The same dynamicNode as in the snippet (also note: self reference).
			sn(nil, { t({ "", "\t\\item " }), i(1), d(2, rec_ls, {}) }),
		}),
	})
end

return {
	s("ls", {
		t({ "\\begin{" }),
		c(1, {
			t("itemize"),
			t("enumerate"),
			i(nil),
		}),
		t({ "}", "\t\\item " }),
		i(2),
		d(3, rec_ls, {}),
		t({ "", "\\end{" }),
		rep(1),
		t("}"),
		i(0),
	}),
	s("aligned", {
		t({ [[\begin{aligned}]] }),
		i(0),
		t({ [[\end{aligned}]] }),
	}),
	s("theo:ref", {
		t({ [[Theorem~\ref{]] }),
		i(0, "theo:"),
		t({ [[}]] }),
	}),
}
