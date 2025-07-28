local wezterm = require("wezterm")
local config = require("tabline.config")
local util = require("tabline.util")
local colors = config.theme.colors
local foreground_process_info = ""
local name = ""

return {
	default_opts = {
		process_to_icon = {
			["air"] = { wezterm.nerdfonts.md_language_go, color = { fg = colors.brights[5] } },
			["apt"] = { wezterm.nerdfonts.dev_debian, color = { fg = colors.ansi[2] } },
			["bacon"] = { wezterm.nerdfonts.dev_rust, color = { fg = colors.ansi[2] } },
			["bash"] = { wezterm.nerdfonts.cod_terminal_bash, color = { fg = colors.cursor_bg or nil } },
			["bat"] = { wezterm.nerdfonts.md_bat, color = { fg = colors.ansi[5] } },
			["btm"] = { wezterm.nerdfonts.md_chart_donut_variant, color = { fg = colors.ansi[2] } },
			["btop"] = { wezterm.nerdfonts.md_chart_areaspline, color = { fg = colors.ansi[2] } },
			["btop4win++"] = { wezterm.nerdfonts.md_chart_areaspline, color = { fg = colors.ansi[2] } },
			["bun"] = { wezterm.nerdfonts.md_hamburger, color = { fg = colors.cursor_bg or nil } },
			["cargo"] = { wezterm.nerdfonts.dev_rust, color = { fg = colors.ansi[2] } },
			["chezmoi"] = { wezterm.nerdfonts.md_home_plus_outline, color = { fg = colors.brights[5] } },
			["cmd.exe"] = { wezterm.nerdfonts.md_console_line, color = { fg = colors.cursor_bg or nil } },
			["curl"] = wezterm.nerdfonts.md_flattr,
			["debug"] = { wezterm.nerdfonts.cod_debug, color = { fg = colors.ansi[5] } },
			["default"] = wezterm.nerdfonts.md_application,
			["docker"] = { wezterm.nerdfonts.md_docker, color = { fg = colors.ansi[5] } },
			["docker-compose"] = { wezterm.nerdfonts.md_docker, color = { fg = colors.ansi[5] } },
			["dpkg"] = { wezterm.nerdfonts.dev_debian, color = { fg = colors.ansi[2] } },
			["fish"] = { wezterm.nerdfonts.md_fish, color = { fg = colors.cursor_bg or nil } },
			["gh"] = { wezterm.nerdfonts.dev_github_badge, color = { fg = colors.brights[4] or nil } },
			["git"] = { wezterm.nerdfonts.dev_git, color = { fg = colors.brights[4] or nil } },
			["go"] = { wezterm.nerdfonts.md_language_go, color = { fg = colors.brights[5] } },
			["htop"] = { wezterm.nerdfonts.md_chart_areaspline, color = { fg = colors.ansi[2] } },
			["kubectl"] = { wezterm.nerdfonts.md_docker, color = { fg = colors.ansi[5] } },
			["kuberlr"] = { wezterm.nerdfonts.md_docker, color = { fg = colors.ansi[5] } },
			["lazydocker"] = { wezterm.nerdfonts.md_docker, color = { fg = colors.ansi[5] } },
			["lazygit"] = { wezterm.nerdfonts.cod_github, color = { fg = colors.brights[4] or nil } },
			["lf"] = { wezterm.nerdfonts.cod_folder, color = { fg = colors.brights[4] or nil } },
			["lua"] = { wezterm.nerdfonts.seti_lua, color = { fg = colors.ansi[5] } },
			["make"] = wezterm.nerdfonts.seti_makefile,
			["nix"] = { wezterm.nerdfonts.linux_nixos, color = { fg = colors.ansi[5] } },
			["node"] = { wezterm.nerdfonts.md_nodejs, color = { fg = colors.brights[2] } },
			["npm"] = { wezterm.nerdfonts.md_npm, color = { fg = colors.brights[2] } },
			["nvim"] = { wezterm.nerdfonts.custom_neovim, color = { fg = colors.ansi[3] } },
			["pacman"] = { wezterm.nerdfonts.md_pac_man, color = { fg = colors.ansi[4] } },
			["paru"] = { wezterm.nerdfonts.md_pac_man, color = { fg = colors.ansi[4] } },
			["pnpm"] = { wezterm.nerdfonts.md_npm, color = { fg = colors.brights[4] } },
			["postgresql"] = { wezterm.nerdfonts.dev_postgresql, color = { fg = colors.ansi[5] } },
			["powershell.exe"] = { wezterm.nerdfonts.md_console, color = { fg = colors.cursor_bg or nil } },
			["psql"] = { wezterm.nerdfonts.dev_postgresql, color = { fg = colors.ansi[5] } },
			["pwsh.exe"] = { wezterm.nerdfonts.md_console, color = { fg = colors.cursor_bg or nil } },
			["rpm"] = { wezterm.nerdfonts.dev_redhat, color = { fg = colors.ansi[2] } },
			["redis"] = { wezterm.nerdfonts.dev_redis, color = { fg = colors.ansi[5] } },
			["ruby"] = { wezterm.nerdfonts.cod_ruby, color = { fg = colors.brights[2] } },
			["rust"] = { wezterm.nerdfonts.dev_rust, color = { fg = colors.ansi[2] } },
			["serial"] = wezterm.nerdfonts.md_serial_port,
			["ssh"] = wezterm.nerdfonts.md_ssh,
			["sudo"] = wezterm.nerdfonts.fa_hashtag,
			["tls"] = wezterm.nerdfonts.md_power_socket,
			["topgrade"] = { wezterm.nerdfonts.md_rocket_launch, color = { fg = colors.ansi[5] } },
			["unix"] = wezterm.nerdfonts.md_bash,
			["valkey"] = { wezterm.nerdfonts.dev_redis, color = { fg = colors.brights[5] } },
			["vim"] = { wezterm.nerdfonts.dev_vim, color = { fg = colors.ansi[3] } },
			["wget"] = wezterm.nerdfonts.md_arrow_down_box,
			["yarn"] = { wezterm.nerdfonts.seti_yarn, color = { fg = colors.ansi[5] } },
			["yay"] = { wezterm.nerdfonts.md_pac_man, color = { fg = colors.ansi[4] } },
			["yazi"] = { wezterm.nerdfonts.md_duck, color = { fg = colors.brights[4] or nil } },
			["yum"] = { wezterm.nerdfonts.dev_redhat, color = { fg = colors.ansi[2] } },
			["zsh"] = { wezterm.nerdfonts.dev_terminal, color = { fg = colors.cursor_bg or nil } },
		},
	},
	update = function(tab, opts)
		local active_pane = tab.active_pane
		local tab_title = tab.tab_title

		if active_pane and active_pane.foreground_process_name then
			local args = wezterm.mux.get_pane(active_pane.pane_id):get_foreground_process_info()

			foreground_process_info = util.pick_argv_with_icon(args, opts.process_to_icon)
				or active_pane.foreground_process_name
		end

		name = tab_title == "" and foreground_process_info or tab_title

		if opts.icons_enabled then
			util.overwrite_icon(opts, opts.process_to_icon[foreground_process_info] or opts.process_to_icon["default"])
		end

		return name
	end,
}
