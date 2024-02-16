-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Normal = {
		bg = "NONE",
	},
	Comment = {
		italic = true,
	},
	TbLineBufOn = {
		bg = "NONE",
	},
	TbLineBufOnClose = {
		bg = "NONE",
	},
	TbLineBufOnModified = {
		bg = "NONE",
	},
	TbLineBufOff = {
		bg = "#151921",
	},
	TbLineBufOffClose = {
		bg = "#151921",
	},
	TbLineBufOffModified = {
		bg = "NONE",
	},
	TblineFill = {
		bg = "NONE",
	},
	Search = {
		fg = "#ffffff",
		bg = "#151921",
	},
}

---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
