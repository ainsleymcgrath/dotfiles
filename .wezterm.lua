local wezterm = require("wezterm")

local function appearance_is_dark(appearance)
	return appearance:find("Dark")
end

local function get_scheme(appearance)
	if appearance_is_dark(appearance) then
		return "neobones_dark"
	else
		return "neobones_light"
	end
end

-- comment in when using modified zenbones theme
-- (using neobones as light theme for now, so `colors` config setting not neded)
local function get_colors(appearance)
	if appearance_is_dark(appearance) then
		return {
			-- customize to match neobones_dark
			tab_bar = {
				background = "#0F191F",
				inactive_tab = { bg_color = "#0F191F", fg_color = "#4A5E6A" },
				active_tab = { bg_color = "#66A5AD", fg_color = "#FFFFFF" },
				new_tab = { bg_color = "#1C2A32", fg_color = "#4A5E6A" },
			},
		}
	else
		return {
			tab_bar = {
				background = "#E5EDE6",
				inactive_tab = { bg_color = "#E5EDE6", fg_color = "#4A5E6A" },
				active_tab = { bg_color = "#D3ADCB", fg_color = "#000000" },
				new_tab = { bg_color = "#E5EDE6", fg_color = "#4A5E6A" },
			},
		}
	end
end

return {
	-- Remove top bar
	window_decorations = "RESIZE",

	-- Style
	font = wezterm.font_with_fallback({ "Iosevka Term Medium", "Iosevka" }),
	font_size = 15.5,
	font_rules = {
		-- default italic is ugly; use oblique to avoid silly cursive
		{ italic = true, font = wezterm.font_with_fallback({ "Iosevka Term Oblique", "Iosevka Oblique" }) },
	},
	hide_tab_bar_if_only_one_tab = true,
	tab_max_width = 44,
	window_padding = {
		left = "0.7cell",
		right = "0.7cell",
		top = "0.5cell",
		bottom = 0,
	},
	use_fancy_tab_bar = false,
	color_scheme = get_scheme(wezterm.gui.get_appearance()),
	colors = get_colors(wezterm.gui.get_appearance()),
	window_frame = {
		font = wezterm.font_with_fallback({ "Iosevka Term", "Iosevka" }),
	},
	initial_cols = 114,
	initial_rows = 29,

	-- Bell
	audible_bell = "Disabled",
	visual_bell = {
		fade_in_function = "EaseIn",
		fade_in_duration_ms = 15,
		fade_out_function = "EaseOut",
		fade_out_duration_ms = 150,
	},

	-- System
	animation_fps = 60, -- TODO: Can this depend on battery charge/screen performance?
	unicode_version = 14,
	keys = {
		{ key = "N", mods = "CMD|SHIFT", action = wezterm.action.ToggleFullScreen },
		{ key = "d", mods = "CMD", action = wezterm.action.SplitPane({ direction = "Right" }) },
		{ key = "D", mods = "CMD|SHIFT", action = wezterm.action.SplitPane({ direction = "Down" }) },
		{ key = "w", mods = "CMD", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		{ key = "0", mods = "CMD", action = wezterm.action.PaneSelect },
		{ key = "Enter", mods = "CMD|SHIFT", action = wezterm.action.TogglePaneZoomState },
		{
			key = "H",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Left"),
		},
		{
			key = "L",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Right"),
		},
		{
			key = "K",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Up"),
		},
		{
			key = "J",
			mods = "CMD|SHIFT",
			action = wezterm.action.ActivatePaneDirection("Down"),
		},
		-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bb" }) },
		-- Make Option-Right equivalent to Alt-f; forward-word
		{ key = "RightArrow", mods = "OPT", action = wezterm.action({ SendString = "\x1bf" }) },
	},
}
