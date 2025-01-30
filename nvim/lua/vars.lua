_G.NIXOS = (string.match(vim.loop.os_uname().version, 'NixOS') and 1 or 0)

_G.FORMATTERS = {
    lua = { 'stylua' },
    nix = { 'alejandra' },
}
