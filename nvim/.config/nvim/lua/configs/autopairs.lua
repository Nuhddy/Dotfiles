require("nvim-autopairs").setup {
    check_ts = true,
    ts_config = {
        lua = { "string" },
    },
    disable_filetype = { "TelescopePrompt" },
    fast_wrap = {
        map = "<m-e>",
        chars = { "{", "[", "(", "<", '"', "'" },
        offset = 0,
        end_key = "$",
        keys = "qwertyuiopasdfghjkl",
        check_comma = true,
    },
}

local cmp_ok, cmp = pcall(require, "cmp")
if not cmp_ok then return end

local cmp_autopairs = require "nvim-autopairs.completion.cmp"

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
