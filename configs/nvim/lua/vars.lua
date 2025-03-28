_G.OS = (
    string.match(vim.loop.os_uname().version, 'NixOS') and 'NixOS'
    or string.match(vim.loop.os_uname().version, 'Windows') and 'Windows'
    or string.match(vim.loop.os_uname().release, 'WSL') and 'WSL'
    or 'unknown'
)

_G.FORMATTERS = {
    lua = { 'stylua' },
    nix = { 'alejandra' },
}
