local status_ok_mason, mason = pcall(require, 'mason')
if not status_ok_mason then
    return
end

local status_ok_mason_lspc, mason_lspc = pcall(require, 'mason-lspconfig')
if not status_ok_mason_lspc then
    return
end


mason.setup {
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
}

mason_lspc.setup {
    automatic_installation = true,
}
