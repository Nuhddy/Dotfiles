require("lualine").setup {
    winbar = {
        lualine_a = { "filename" },
        lualine_c = {
            {
                require("nvim-navic").get_location,
                cond = require("nvim-navic").is_available,
            },
        },
    },
    inactive_winbar = {
        lualine_a = { "filename" },
    },
}
