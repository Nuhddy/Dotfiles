return {
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        opts = {
            check_ts = true,
            ts_config = {
                lua = { 'string' },
            },
        },
    },
    {
        'kylechui/nvim-surround',
        version = '*',
        event = 'VeryLazy',
        config = true,
    },
}
