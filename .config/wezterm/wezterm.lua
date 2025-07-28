local wezterm = require("wezterm")
local smart_splits = wezterm.plugin.require("https://github.com/mrjones2014/smart-splits.nvim")
local tabline = wezterm.plugin.require("file:///home/molyi/.config/wezterm/plugins/tabline.wez")
local config = wezterm.config_builder()

-- Keybinds
require("keybinds").apply_to_config(config)

smart_splits.apply_to_config(config, {
	direction_keys = {
		move = { "h", "j", "k", "l" },
		resize = { "h", "j", "k", "l" },
	},

	modifiers = {
		move = "CTRL",
		resize = "CTRL|ALT",
	},

	log_level = "info",
})

-- Font
require("font").apply_to_config(config)

-- Appearance
config.window_background_opacity = 0.85
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
}
config.window_padding = { left = "0.5cell", right = "0.5cell", top = "0.25cell", bottom = 0 }
config.window_decorations = "NONE"
config.inactive_pane_hsb = {
	saturation = 0.8,
	brightness = 0.3,
}

-- Other
config.window_close_confirmation = "NeverPrompt"
config.prefer_egl = true
config.enable_wayland = true
config.set_environment_variables = {
	TERM = "xterm-256color",
	WINIT_X11_SCALE_FACTOR = "1",
}

-- Colors
config.colors = {
	foreground = "#ffffff",
	background = "#000000",

	cursor_bg = "#ffffff",
	cursor_fg = "#000000",
	cursor_border = "#ffffff",

	ansi = {
		"#000000", -- black
		"#ff5555", -- red
		"#55ff55", -- green
		"#ffff55", -- yellow
		"#5555ff", -- blue
		"#ff55ff", -- magenta
		"#55ffff", -- cyan
		"#ffffff", -- white
	},

	brights = {
		"#555555", -- bright black
		"#ff5555", -- bright red
		"#55ff55", -- bright green
		"#ffff55", -- bright yellow
		"#5555ff", -- bright blue
		"#ff55ff", -- bright magenta
		"#55ffff", -- bright cyan
		"#ffffff", -- bright white
	},

	tab_bar = {
		background = "transparent",
		active_tab = {
			bg_color = "rgba(0% 0% 0% 0%)",
			fg_color = "#ffffff",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "rgba(0% 0% 0% 0%)",
			fg_color = "rgba(100% 100% 100% 100%)",
			intensity = "Normal",
		},
		new_tab = {
			bg_color = "rgba(0% 0% 0% 0%)",
			fg_color = "#ffffff",
		},
	},
}

tabline.setup({
	options = {
		icons_enabled = true,
		theme = config.colors,
		tabs_enabled = true,
		theme_overrides = {},
		section_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
		component_separators = {
			left = wezterm.nerdfonts.pl_left_soft_divider,
			right = wezterm.nerdfonts.pl_right_soft_divider,
		},
		tab_separators = {
			left = wezterm.nerdfonts.pl_left_hard_divider,
			right = wezterm.nerdfonts.pl_right_hard_divider,
		},
	},
	sections = {
		tabline_a = { "mode" },
		tabline_b = {},
		tabline_c = {},
		tab_active = {
			"index",
			{ "processl", padding = { left = 0, right = 0 } },
		},
		tab_inactive = {
			"index",
			{ "processl", padding = { left = 0, right = 0 } },
		},
		tabline_x = {},
		tabline_y = {},
		tabline_z = { "datetime" },
	},
	extensions = {},
})

return config
