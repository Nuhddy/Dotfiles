local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
    return
end

local a = require 'telescope.actions'

telescope.setup {
    defaults = {
        prompt_prefix = '  ',
        selection_caret = '  ',
        path_display = { 'smart' },
        mappings = {
            i = {
                ['<C-n>'] = a.cycle_history_next,
                ['<C-p>'] = a.cycle_history_prev,

                ['<C-j>'] = a.move_selection_next,
                ['<C-k>'] = a.move_selection_previous,

                ['<C-c>'] = a.close,

                ['<CR>'] = a.select_default,
                ['<C-x>'] = a.select_horizontal,
                ['<C-v>'] = a.select_vertical,
                ['<C-t>'] = a.select_tab,

                ['<C-u>'] = a.preview_scrolling_up,
                ['<C-d>'] = a.preview_scrolling_down,

                ['<C-y>'] = a.results_scrolling_up,
                ['<C-e>'] = a.results_scrolling_down,

                ['<Tab>'] = a.toggle_selection + a.move_selection_worse,
                ['<S-Tab>'] = a.toggle_selection + a.move_selection_better,

                ['<C-/>'] = a.which_key,
            },
            n = {
                ['j'] = a.move_selection_next,
                ['k'] = a.move_selection_previous,
                ['H'] = a.move_to_top,
                ['M'] = a.move_to_middle,
                ['L'] = a.move_to_bottom,

                ['<ESC>'] = a.close,

                ['<CR>'] = a.select_default,
                ['<C-x>'] = a.select_horizontal,
                ['<C-v>'] = a.select_vertical,
                ['<C-t>'] = a.select_tab,

                ['<C-u>'] = a.preview_scrolling_up,
                ['<C-d>'] = a.preview_scrolling_down,

                ['<C-y>'] = a.results_scrolling_up,
                ['<C-e>'] = a.results_scrolling_down,

                ['<Tab>'] = a.toggle_selection + a.move_selection_worse,
                ['<S-Tab>'] = a.toggle_selection + a.move_selection_better,

                ['?'] = a.which_key,
            },
        },
    },
    pickers = {
        find_files = {
            theme = 'dropdown',
            previewer = false,
        },
    },
}
