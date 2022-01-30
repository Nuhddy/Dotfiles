local project_status_ok, project = pcall(require, 'project_nvim')
if not project_status_ok then
    return
end

project.setup {
    manual_mode = true,
    detection_methods = { 'lsp', 'pattern' },
    patterns = {
        '.git',
        '_darcs',
        '.hg',
        '.bzr',
        '.svn',
        'Makefile',
        'package.json',
    },

    ignore_lsp = {},
    exclude_dirs = {},

    show_hidden = false,
    silent_chdir = true,

    datapath = vim.fn.stdpath 'data',
}

local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
    return
end

telescope.load_extension('projects')
