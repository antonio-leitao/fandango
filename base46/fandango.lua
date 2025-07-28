-- Credits to original https://github.com/antonio-leitao/fandango
-- This is simplified version of it

local M = {}

M.base_30 = {
	white = "#e7e8e9",
	darker_black = "#0c0e11",
	black = "#0e1114", --  nvim bg
	black2 = "#13171b",
	one_bg = "#1c2329",
	one_bg2 = "#1c2329",
	one_bg3 = "#2e3c44",
	grey = "#2e3c44",
	grey_fg = "#2e3c44",
	grey_fg2 = "#2e3c44",
	light_grey = "#87959b",
	red = "#f2856d",
	baby_pink = "#ce8196",
	pink = "#ff75a0",
	line = "#13171b", -- for lines like vertsplit
	green = "#89b482",
	vibrant_green = "#a9b665",
	nord_blue = "#8ca7d7",
	blue = "#8ca7d7",
	yellow = "#f2b56b",
	sun = "#f2b56b",
	purple = "#d59c9f",
	dark_purple = "#b293bf",
	teal = "#829e97",
	orange = "#f2856d",
	cyan = "#8ed8f8",
	statusline_bg = "#13171b",
	lightbg = "#13171b",
	pmenu_bg = "#d59c9f",
	folder_bg = "#f2b56b",
}

M.base_16 = {
	base00 = "#0e1114",
	base01 = "#13171b",
	base02 = "#13171b",
	base03 = "#13171b",
	base04 = "#13171b",
	base05 = "#D4cDc0",
	base06 = "#2e3c44",
	base07 = "#2e3c44",
	base08 = "#8ca7d7",
	base09 = "#d59c9f",
	base0A = "#b293bf",
	base0B = "#c1d98f",
	base0C = "#8ed8f8",
	base0D = "#f2b56b",
	base0E = "#f2856d",
	base0F = "#d65d0e",
}

M.type = "dark"

M = require("base46").override_theme(M, "fandango")

return M
