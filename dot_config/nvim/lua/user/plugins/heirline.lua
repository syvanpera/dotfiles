return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astronvim.utils.status"
    local conditions = require "heirline.conditions"

    opts.winbar = nil
    -- opts.statusline[3] = status.component.file_info { filetype = {}, filename = true }

    opts.statusline = {
      hl = { fg = "fg", bg = "bg" },
      status.component.mode(),
      status.component.git_branch(),
      status.component.file_info { filetype = false, filename = {}, file_modified = false },
      status.component.git_diff { condition = conditions.is_active },
      status.component.diagnostics { condition = conditions.is_active },
      status.component.fill { condition = conditions.is_active },
      status.component.cmd_info { condition = conditions.is_active },
      status.component.fill { condition = conditions.is_active },
      status.component.lsp { condition = conditions.is_active },
      status.component.treesitter { condition = conditions.is_active },
      status.component.nav { condition = conditions.is_active },
      status.component.mode { condition = conditions.is_active, surround = { separator = "right" } },
    }

    return opts
  end,
}
