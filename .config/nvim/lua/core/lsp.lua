-- Prefix completion kinds with a nerd font icon, e.g. "󰊕 Function"
local function convert(item)
  local kind = vim.lsp.protocol.CompletionItemKind[item.kind] or "Unknown"
  local icon, hl = require("mini.icons").get("lsp", kind)
  return { kind = icon .. " " .. kind, kind_hlgroup = hl }
end

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "Enable built-in LSP completion",
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true, convert = convert })
    end
  end,
})

-- The completion docs popup ignores 'winborder', so apply it manually. Nvim sizes
-- the popup without a border, so shrink it to keep it on screen and off the menu.
local function set_border(winid)
  local border = vim.o.winborder
  if border == "" or border == "none" or not (winid and winid > 0 and vim.api.nvim_win_is_valid(winid)) then
    return
  end
  local cfg = vim.api.nvim_win_get_config(winid)
  local pum = vim.fn.pum_getpos()
  local right_edge = vim.o.columns
  if pum.col and cfg.col < pum.col then
    -- popup is left of the menu, stop before the menu's border
    right_edge = pum.col - (vim.o.pumborder ~= "" and vim.o.pumborder ~= "none" and 1 or 0)
  end
  local bottom_edge = vim.o.lines - vim.o.cmdheight - (vim.o.laststatus > 0 and 1 or 0)
  vim.api.nvim_win_set_config(winid, {
    border = border,
    width = math.max(1, math.min(cfg.width, right_edge - cfg.col - 2)),
    height = math.max(1, math.min(cfg.height, bottom_edge - cfg.row - 2)),
  })
end

vim.api.nvim_create_autocmd("CompleteChanged", {
  desc = "Add border to completion docs popup",
  group = vim.api.nvim_create_augroup("completion-border", { clear = true }),
  callback = function()
    vim.schedule(function()
      set_border(vim.fn.complete_info({ "selected" }).preview_winid)
    end)
  end,
})

-- LSP docs are resolved asynchronously and can open the popup after CompleteChanged
local complete_set = vim.api.nvim__complete_set
vim.api.nvim__complete_set = function(...)
  local windata = complete_set(...)
  set_border(windata.winid)
  return windata
end
