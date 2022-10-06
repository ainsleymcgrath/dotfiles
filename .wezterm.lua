local wezterm = require("wezterm")

local function appearance_is_dark(appearance)
	return appearance:find("Dark")
end

local custom_light_theme = {
	foreground = "#2C363C",
	background = "#F0EDEC",
	cursor_bg = "#2C363C",
	cursor_border = "#F0EDEC",
	cursor_fg = "#F0EDEC",
	selection_bg = "#CBD9E3",
	selection_fg = "#2C363C",
	ansi = { "#F0EDEC", "#A8334C", "#4F6C31", "#944927", "#286486", "#88507D", "#3B8992", "#2C363C" },
	brights = { "#CFC1BA", "#94253E", "#3F5A22", "#803D1C", "#1D5573", "#7B3B70", "#2B747C", "#4F5E68" },
	visual_bell = "#DDD6D3",
	tab_bar = {
		inactive_tab_edge = "#DDD6D3",
		background = "#DDD6D3",
		active_tab = {
			bg_color = "#F0EDEC",
			fg_color = "#2C363C",
		},
		inactive_tab = {
			bg_color = "#DDD6D3",
			fg_color = "#2C363C",
		},
		inactive_tab_hover = {
			bg_color = "#F0EDEC",
			fg_color = "#2C363C",
		},
		new_tab = {
			bg_color = "#DDD6D3",
			fg_color = "#2C363C",
		},
		new_tab_hover = {
			bg_color = "#DDD6D3",
			fg_color = "#2C363C",
		},
	},
}

-- two separate functions because i need to call these in the `return` below
-- with wezterm.gui.get_appearance(). it _seems_ like that value is like...missing
-- outside the scope of that return?
local function get_scheme(appearance)
	if appearance_is_dark(appearance) then
		return "zenbones_dark"
	else
		return nil
	end
end

local function get_colors(appearance)
	if appearance_is_dark(appearance) then
		return nil
	else
		-- Theme [Modified Zenbones] [Thanks, Salomon]
		return custom_light_theme
	end
end

return {
	-- Remove top bar
	window_decorations = "RESIZE",

	-- Style
	font = wezterm.font_with_fallback({ "Iosevka Term Medium", "Iosevka" }),
	font_size = 15.0,
	font_rules = {
		-- default italic is ugly; use oblique to avoid silly cursive
		{ italic = true, font = wezterm.font_with_fallback({ "Iosevka Term Oblique", "Iosevka Oblique" }) },
	},
	hide_tab_bar_if_only_one_tab = true,
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
