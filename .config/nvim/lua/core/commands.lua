local function plugin_names()
  return vim.tbl_map(function(p) return p.spec.name end, vim.pack.get())
end

vim.api.nvim_create_user_command("PackAdd", function(opts)
  local specs = vim.tbl_map(function(arg)
    return arg:find("://", 1, true) and arg or "https://github.com/" .. arg
  end, opts.fargs)
  vim.pack.add(specs)
end, { nargs = "+", desc = "Add plugins (:PackAdd user/repo1 user/repo2)" })

-- Pack Delete and Update cmds are built-in on Nightly 0.13
vim.api.nvim_create_user_command("PackDel", function(opts)
  vim.pack.del(opts.fargs)
end, { nargs = "+", complete = plugin_names, desc = "Delete plugins (:PackDel plugin1 plugin2)" })

vim.api.nvim_create_user_command("PackUpdate", function(opts)
  vim.pack.update(#opts.fargs > 0 and opts.fargs or nil)
end, { nargs = "*", complete = plugin_names, desc = "Update all plugins or specific ones" })
