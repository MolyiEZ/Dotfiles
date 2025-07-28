return {
	default_opts = {},
	update = function(tab)
		local tab_title = tab.tab_title
		return tab_title == "" and "default" or tab_title
	end,
}
