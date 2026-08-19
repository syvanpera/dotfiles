return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "classic", -- modern/classic/helix
        spec = {
            {
                { "<leader>f", group = "find" },
                { "<leader>g", group = "git" },
            },
        },
    },
}
