return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
        ensure_installed = {
            "bash",
            "lua",
            "markdown",
            "markdown_inline",
            "vim",
        },
        auto_install = true,
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<Enter>",
                node_incremental = "<Enter>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },
        textobjects = {
            select = {
                enable = false,
            },
        },
    },
}
