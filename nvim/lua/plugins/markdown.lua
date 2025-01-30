return {
    {
        'iamcco/markdown-preview.nvim',
        cmd = {
            'MarkdownPreviewToggle',
            'MarkdownPreview',
            'MarkdownPreviewStop',
        },
        ft = { 'markdwon' },
        build = ':call mkdp#util#install()',
    },
    -- 'vim-pandoc/vim-pandoc',
    'vim-pandoc/vim-pandoc-syntax',
}
