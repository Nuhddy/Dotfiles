local status_ok, indentline = pcall(require, 'indent_blankline')
if not status_ok then
    return
end

indentline.setup {
    char = '¦',
    char_highlight_list = { 'IndentBlanklineIndent1' },
    buftype_exclude = { 'terminal', 'help', 'nofile', 'prompt' },
}
