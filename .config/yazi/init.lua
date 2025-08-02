require("session"):setup({
	sync_yanked = true,
})

require("full-border"):setup({
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.PLAIN,
})

function Header:cwd()
	local max = self._area.w - self._right_width
	if max <= 0 then
		return ui.Span("")
	end
	local cwd = ya.readable_path(tostring(self._tab.current.cwd)) .. self:flags()
	local target = cx.active.current.hovered and tostring(cx.active.current.hovered.name) or ""
	return ui.Line({
		ui.Span("  "):fg("#ffffff"):bg("#232627"),
		ui.Span(""):fg("#232627"):bg("#282f3e"),
		ui.Span(" " .. cwd .. " "):fg("#ffffff"):bg("#282f3e"),
		ui.Span(""):fg("#282f3e"):bg("#3a4359"),
		ui.Span(" " .. target .. " "):fg("#ffffff"):bg("#3a4359"),
	})
end
