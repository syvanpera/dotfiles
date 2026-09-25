vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",
})

-- Server binaries come from Nix; servers not on PATH are skipped
vim.lsp.enable({
  "lua_ls",
  "stylua",
  "qmlls",
  "ts_ls",
  "gopls",
  "jsonls",
  "yamlls",
  "tailwindcss",
  "biome",
})

-- Teach lua_ls about the Neovim runtime and plugins. Done at startup because
-- $VIMRUNTIME is a Nix store path that changes on every update. Projects with
-- their own .luarc.json (e.g. the Hyprland config) are left alone.
vim.lsp.config("lua_ls", {
  on_init = function(client)
    local root = client.workspace_folders and client.workspace_folders[1].name
    if root and (vim.uv.fs_stat(root .. "/.luarc.json") or vim.uv.fs_stat(root .. "/.luarc.jsonc")) then
      return
    end
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
      runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
      workspace = {
        checkThirdParty = false,
        library = vim.list_extend({ vim.env.VIMRUNTIME }, vim.api.nvim_get_runtime_file("lua", true)),
      },
    })
  end,
})
