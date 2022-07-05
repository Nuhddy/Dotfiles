local ls = require 'luasnip'

local s = ls.snippet
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
-- local t = ls.text_node
local i = ls.insert_node
-- local f = ls.function_node
-- local c = ls.choice_node
-- local d = ls.dynamic_node
-- local r = ls.restore_node
-- local events = require 'luasnip.util.events'
-- local ai = require 'luasnip.nodes.absolute_indexer'
local fmt = require('luasnip.extras.fmt').fmt
-- local m = require('luasnip.extras').m
-- local lambda = require('luasnip.extras').l
-- local postfix = require('luasnip.extras.postfix').postfix
local rep = require('luasnip.extras').rep

ls.add_snippets('lua', {
    s({
        trig = 'safereq',
        dscr = 'Import module in protected call. Return on error.'
    },
    fmt(
        [[
            local {}, {} = pcall(require, '{}')
            if not {} then
                return
            end
            {}
        ]],
        { i(1, 'status_ok'), i(2, '_'), i(3), rep(1), i(0) })
    ),
})

ls.add_snippets('tex', {
    s({
        trig = 'infer',
        dscr = 'Infer w/ label (optional), conclusion & premise(s)'
    },
    fmt(
        [[
            \infer[<>]
                {<>}
                {<>}

            <>
        ]],
        { i(1, ''), i(2, 'conclusion'), i(3, 'premise(s)'), i(0) },
        { delimiters = '<>' })
    ),
})
