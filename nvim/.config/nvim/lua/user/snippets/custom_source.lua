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
        trig = '\\i1',
        dscr = 'Infer with 1 premise'
    },
    fmt(
        [[
            \infer[<>]
                {<>}
                {<>}

            <>
        ]],
        { i(1, 'label'), i(2, 'conclusion'), i(3, 'premise'), i(0) },
        { delimiters = '<>' })
    ),
    s({
        trig = '\\i2',
        dscr = 'Infer with 2 premises'
    },
    fmt(
        [[
            \infer[<>]
                {<>}
                {<> &
                <>}

            <>
        ]],
        { i(1, 'label'), i(2, 'conclusion'), i(3, 'p1'), i(4, 'p2'), i(0) },
        { delimiters = '<>' })
    ),
    s({
        trig = '\\i3',
        dscr = 'Infer with 3 premises'
    },
    fmt(
        [[
            \infer[<>]
                {<>}
                {<> &
                <> &
                <>}

            <>
        ]],
        { i(1, 'label'), i(2, 'conclusion'), i(3, 'p1'), i(4, 'p2'), i(5, 'p3'), i(0) },
        { delimiters = '<>' })
    ),
})
