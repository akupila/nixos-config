local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.color_scheme = "ayu"
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.font = wezterm.font({
	family = "Hack Nerd Font",
})
config.font_size = 13.0
config.adjust_window_size_when_changing_font_size = false
config.window_decorations = "RESIZE"

config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "1cell",
	bottom = "0.5cell",
}

config.inactive_pane_hsb = {
	saturation = 0.9,
	brightness = 0.6,
}

config.keys = {
	-- Move with cmd-hjkl
	{
		key = "h",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		key = "j",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
	{
		key = "k",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		key = "l",
		mods = "SUPER",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},

	-- Resize with cmd-shift-hjkl
	{
		key = "h",
		mods = "SUPER|SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }),
	},
	{
		key = "j",
		mods = "SUPER|SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Down", 3 } }),
	},
	{
		key = "k",
		mods = "SUPER|SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Up", 3 } }),
	},
	{
		key = "l",
		mods = "SUPER|SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }),
	},

	-- Divide horizontally and vertically with cmd-d and cmd-shift-d
	{
		key = "d",
		mods = "SUPER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},

	-- Rename tab title with ctrl-shift-e
	-- https://github.com/wez/wezterm/issues/522#issuecomment-1496894508
	{
		key = "E",
		mods = "CTRL|SHIFT",
		action = wezterm.action.PromptInputLine({
			description = "Enter new name for tab",
			action = wezterm.action_callback(function(window, _, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},

	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({
			confirm = true,
		}),
	},
}

for i = 1, 9 do
	-- CTRL+ALT + number to move to that position
	table.insert(config.keys, {
		key = tostring(i),
		mods = "CTRL|ALT",
		action = wezterm.action.MoveTab(i - 1),
	})
end

return config
