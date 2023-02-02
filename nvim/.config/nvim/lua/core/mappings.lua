local set_mappings = require("core.utils").set_mappings

local maps = { i = {}, n = {}, t = {}, v = {}, [""] = {} }

local default_options = { silent = true }

-- navigation
maps.n["<c-h>"] = { "<c-w>h", desc = "Go to pane to the left" }
maps.n["<c-j>"] = { "<c-w>j", desc = "Go to pane below" }
maps.n["<c-k>"] = { "<c-w>k", desc = "Go to pane above" }
maps.n["<c-l>"] = { "<c-w>l", desc = "Go to pane to the right" }

maps.n["<a-h>"] = { "<cmd>bprevious<cr>", desc = "Go to previous buffer" }
maps.n["<a-l>"] = { "<cmd>bnext<cr>", desc = "Go to next buffer" }

maps.t["<esc>"] = { "<c-\\><c-n>", desc = "Escape from terminal" }

-- window
maps.n["<c-up>"] = { "<cmd>resize +2<cr>", desc = "Expand pane horizontally" }
maps.n["<c-down>"] = { "<cmd>resize -2<cr>", desc = "Shrink pane horizontally" }
maps.n["<c-left>"] =
{ "<cmd>vertical resize -2<cr>", desc = "Shrink pane vertically" }
maps.n["<c-right>"] =
{ "<cmd>vertical resize +2<cr>", desc = "Expand pane vertically" }

maps.n["<leader>go"] =
{ "<cmd>Goyo<cr>", desc = "Toggle zen/no-distraction mode" }

-- editing
maps.v[">"] = { ">gv", desc = "Indent and stay in visual mode" }
maps.v["<"] = { "<gv", desc = "Unindent and stay in visual mode" }

-- spellcheck
maps.n["<leader>o"] =
{ "<cmd>setlocal spell! spelllang=da,en<cr>", desc = "Toggle spellcheck" }

-- pandoc markdown
maps.n["<leader>xp"] = {
    "<cmd>!pandoc -f markdown -t pdf %<cr><cr>",
    desc = "Compile pandoc markdown to pdf",
}
maps.n["<leader>xe"] = {
    "<cmd>!pandoc -f markdown -t epub %<cr><cr>",
    desc = "Compile pandoc markdown to epub",
}

-- git
maps.n["<leader>gs"] = { "<cmd>Gitsigns toggle_signs<cr>", desc = "" }
maps.n["<leader>gg"] = { "<cmd>Git<cr>", desc = "" }
maps.n["<leader>gc"] = { "<cmd>Gcommit %<cr>", desc = "" }
maps.n["<leader>gw"] = { "<cmd>Gwrite<cr>", desc = "" }

-- other
maps.n["<leader>e"] =
{ "<cmd>NeoTreeRevealToggle<cr>", desc = "Toggle file explorer sidebar" }
maps.n["<leader>mp"] = {
    "<cmd>MarkdownPreviewToggle<cr>",
    desc = "Toggle markdown live preview server",
}
maps.n["<leader>f"] =
{ function() vim.lsp.buf.format() end, desc = "Format buffer content" }
maps.n["<leader>t"] =
{ "<cmd>Telescope find_files<cr>", desc = "Telescope - find files" }

set_mappings(maps, default_options)
