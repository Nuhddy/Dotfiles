local status_ok, bufferline = pcall(require, 'bufferline')
if not status_ok then
    return
end

bufferline.setup {
    options = {
        numbers = 'none',
        close_command = 'bdelete! %d',
        right_mouse_command = 'vertical sbuffer %d',
        left_mouse_command = 'buffer %d',
        middle_mouse_command = 'bdelete! %d',

        indicator = { icon = '▎' },
        buffer_close_icon = '',
        modified_icon = '●',
        close_icon = '',
        left_trunc_marker = '',
        right_trunc_marker = '',

        name_formatter = function(buf)
            if buf.name:match '%.md' then
                return vim.fn.fnamemodify(buf.name, ':t:r')
            end
        end,

        max_name_length = 30,
        max_prefix_length = 30,
        tab_size = 21,
        diagnostics = false,
        diagnostics_update_in_insert = false,

        offsets = { { filetype = 'NvimTree', text = '', padding = 1 } },

        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = true,
        persist_buffer_sort = true,
        separator_style = 'thin',
        enforce_regular_tabs = true,
        always_show_bufferline = false,
    },
}
