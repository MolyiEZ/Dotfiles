local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

local apps = {
	["lf"] = true,
	["nvim"] = true,
}

local function pick_argv_app(proc_info)
	if not proc_info then
		return nil
	end

	local root_argv = proc_info.argv and proc_info.argv[1] or nil

	local queue = {}
	local head, tail = 1, 0

	local function enqueue_children(node)
		local kids = node and node.children
		if not kids then
			return
		end

		local pids = {}
		for pid in pairs(node.children) do
			pids[#pids + 1] = pid
		end
		table.sort(pids)

		for _, pid in ipairs(pids) do
			tail = tail + 1
			queue[tail] = node.children[pid]
		end
	end

	enqueue_children(proc_info)

	-- BFS:
	while head <= tail do
		local node = queue[head]
		head = head + 1

		local arg0 = node.argv and node.argv[1]
		if apps[arg0] then
			return arg0
		end
		enqueue_children(node)
	end

	-- fallback
	return root_argv
end

function module.apply_to_config(config)
	config.disable_default_key_bindings = true
	config.leader = { key = "a", mods = "CTRL" }
	config.keys = {
		{
			key = "h",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(function(window, pane)
				local cwd_dir = pane:get_current_working_dir()

				window:perform_action(
					act.SplitHorizontal({
						domain = "CurrentPaneDomain",
						cwd = cwd_dir.file_path,
					}),
					pane
				)
			end),
		},
		{
			key = "v",
			mods = "LEADER|CTRL",
			action = wezterm.action_callback(function(window, pane)
				local cwd_dir = pane:get_current_working_dir()

				window:perform_action(
					act.SplitVertical({
						domain = "CurrentPaneDomain",
						cwd = cwd_dir.file_path,
					}),
					pane
				)
			end),
		},
		{
			key = "h",
			mods = "LEADER|CTRL|ALT",
			action = wezterm.action_callback(function(window, pane)
				local cwd_dir = pane:get_current_working_dir()
				local proc_info = pane:get_foreground_process_info()
				local arg = pick_argv_app(proc_info)

				window:perform_action(
					act.SplitHorizontal({
						domain = "CurrentPaneDomain",
						cwd = cwd_dir.file_path,
						args = arg and { arg } or nil,
					}),
					pane
				)
			end),
		},
		{
			key = "v",
			mods = "LEADER|CTRL|ALT",
			action = wezterm.action_callback(function(window, pane)
				local cwd_dir = pane:get_current_working_dir()
				local proc_info = pane:get_foreground_process_info()
				local arg = pick_argv_app(proc_info)

				window:perform_action(
					act.SplitVertical({
						domain = "CurrentPaneDomain",
						cwd = cwd_dir.file_path,
						args = arg and { arg } or nil,
					}),
					pane
				)
			end),
		},

		{
			key = "q",
			mods = "LEADER|CTRL",
			action = act.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "q",
			mods = "LEADER|CTRL|ALT",
			action = act.CloseCurrentTab({ confirm = true }),
		},
		{
			key = "t",
			mods = "LEADER|CTRL",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{
			key = "t",
			mods = "LEADER|CTRL|ALT",
			action = wezterm.action_callback(function(window, pane)
				local cwd_dir = pane:get_current_working_dir()
				local proc = pane:get_foreground_process_name()
				local args = nil
				if proc then
					args = { proc }
				end

				window:perform_action(
					act.SpawnCommandInNewTab({
						domain = "CurrentPaneDomain",
						cwd = cwd_dir.path,
						args = args,
						set_environment_variables = { TERM = "screen-256color" },
					}),
					pane
				)
			end),
		},
		{
			key = "f",
			mods = "LEADER|CTRL",
			action = act.ShowTabNavigator,
		},
		{
			key = "n",
			mods = "LEADER|CTRL",
			action = act.SpawnWindow,
		},
		{
			key = "r",
			mods = "LEADER|CTRL",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		{
			key = ",",
			mods = "LEADER|CTRL",
			action = act.SpawnCommandInNewTab({
				args = { "nvim", "/home/molyi/.config/wezterm/wezterm.lua" },
				cwd = "/home/molyi/.config/wezterm",
				domain = "CurrentPaneDomain",
				set_environment_variables = { TERM = "screen-256color" },
			}),
		},
		{
			key = "C",
			mods = "CTRL",
			action = act.CopyTo("Clipboard"),
		},
		{
			key = "C",
			mods = "SHIFT|CTRL",
			action = act.CopyTo("Clipboard"),
		},
		{
			key = "V",
			mods = "CTRL",
			action = act.PasteFrom("Clipboard"),
		},
		{
			key = "V",
			mods = "SHIFT|CTRL",
			action = act.PasteFrom("Clipboard"),
		},
		{ key = "l", mods = "LEADER|CTRL", action = wezterm.action.ShowDebugOverlay },
	}

	for i = 1, 8 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "CTRL",
			action = act.ActivateTab(i - 1),
		})
		table.insert(config.keys, {
			key = tostring(i),
			mods = "CTRL|ALT",
			action = act.MoveTab(i - 1),
		})
	end
end

return module
