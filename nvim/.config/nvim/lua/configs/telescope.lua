local a = require "telescope.actions"

require("telescope").setup {
    defaults = {
        path_display = { "smart" },
        mappings = {
            i = {
                ["<c-n>"] = a.cycle_history_next,
                ["<c-p>"] = a.cycle_history_prev,

                ["<c-j>"] = a.move_selection_next,
                ["<c-k>"] = a.move_selection_previous,
                ["<tab>"] = a.move_selection_next,
                ["<s-tab>"] = a.move_selection_previous,

                ["<c-c>"] = a.close,

                ["<cr>"] = a.select_default,
                ["<c-x>"] = a.select_horizontal,
                ["<c-v>"] = a.select_vertical,
                ["<c-t>"] = a.select_tab,

                ["<c-u>"] = a.preview_scrolling_up,
                ["<c-d>"] = a.preview_scrolling_down,

                ["<c-y>"] = a.results_scrolling_up,
                ["<c-e>"] = a.results_scrolling_down,

                ["<c-/>"] = a.which_key,
            },
            n = {
                ["j"] = a.move_selection_next,
                ["k"] = a.move_selection_previous,
                ["<tab>"] = a.move_selection_next,
                ["<s-tab>"] = a.move_selection_previous,

                ["H"] = a.move_to_top,
                ["M"] = a.move_to_middle,
                ["L"] = a.move_to_bottom,

                ["<esc>"] = a.close,

                ["<cr>"] = a.select_default,
                ["<c-x>"] = a.select_horizontal,
                ["<c-v>"] = a.select_vertical,
                ["<c-t>"] = a.select_tab,

                ["<c-u>"] = a.preview_scrolling_up,
                ["<c-d>"] = a.preview_scrolling_down,

                ["<c-y>"] = a.results_scrolling_up,
                ["<c-e>"] = a.results_scrolling_down,

                ["?"] = a.which_key,
            },
        },
    },
}
