local wezterm = require("wezterm")

local module = {}

function module.apply_to_config(config)
	config.font = wezterm.font_with_fallback({
		{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
		{ family = "JetBrainsMono Nerd Font", weight = "Bold" },
	})
	config.font_size = 16
	config.font_rules = {
		{
			intensity = "Bold",
			italic = false,
			font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold", italic = false }),
		},
		{
			intensity = "Normal",
			italic = true,
			font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular", italic = true }),
		},
	}
end

return module
