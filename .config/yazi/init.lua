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

function Status:mode()
	local mode = tostring(self._tab.mode):upper()

	local style = self:style()
	return ui.Line({
		ui.Span(th.status.sep_left.open):fg(style.main:bg()):bg("reset"),
		ui.Span(" " .. mode .. " "):style(style.main),
		ui.Span(th.status.sep_left.close):fg(style.main:bg()):bg(style.alt:bg()),
	})
end

function Status:size()
	local h = self._current.hovered
	local size = h and (h:size() or h.cha.len) or 0

	local style = self:style()
	return ui.Line({
		ui.Span(" " .. ya.readable_size(size) .. " "):style(style.alt),
		ui.Span(th.status.sep_left.close):fg(style.alt:bg()):bg(th.status.overall:bg()),
	})
end

function Status:percent()
	local percent = 0
	local cursor = self._current.cursor
	local length = #self._current.files
	if cursor ~= 0 and length ~= 0 then
		percent = math.floor((cursor + 1) * 100 / length)
	end

	if percent == 0 then
		percent = " Top "
	elseif percent == 100 then
		percent = " Bot "
	else
		percent = string.format(" %2d%% ", percent)
	end

	local style = self:style()
	return ui.Line({
		ui.Span(" " .. th.status.sep_right.open):fg(style.alt:bg()):bg(th.status.overall:bg()),
		ui.Span(percent):style(style.alt),
	})
end

function Status:name()
	local h = self._current.hovered
	if not h then
		return ui.Line({
			ui.Span(" "):bg(th.status.overall:bg()),
		})
	end

	return ui.Line({
		ui.Span(" " .. h.name:gsub("\r", "?", 1) .. " "):bg(th.status.overall:bg()),
	})
end

function Status:perm()
	local h = self._current.hovered
	if not h then
		return ""
	end

	local perm = h.cha:perm()
	if not perm then
		return ""
	end

	local spans = {}
	spans[#spans + 1] = ui.Span(" "):bg(th.status.overall:bg())

	-- Note: Your loop starts at #spans + 1 (which is 2), so it skips the first char of 'perm'.
	-- This assumes you intentionally want to hide the file type char (e.g. 'd' or '-').
	for i = #spans + 1, #perm do
		local c = perm:sub(i, i)
		local style = th.status.perm_type
		if c == "-" or c == "?" then
			style = th.status.perm_sep
		elseif c == "r" then
			style = th.status.perm_read
		elseif c == "w" then
			style = th.status.perm_write
		elseif c == "x" or c == "s" or c == "S" or c == "t" or c == "T" then
			style = th.status.perm_exec
		end
		spans[i] = ui.Span(c):style(style):bg(th.status.overall:bg())
	end

	return ui.Line(spans)
end

function Status:redraw()
	local left = self:children_redraw(self.LEFT)

	local right = self:children_redraw(self.RIGHT)
	local right_width = right:width()

	return {
		ui.Text(""):area(self._area),
		ui.Line(left):area(self._area),
		ui.Line(right):area(self._area):align(ui.Align.RIGHT),
		table.unpack(ui.redraw(Progress:new(self._area, right_width))),
	}
end
