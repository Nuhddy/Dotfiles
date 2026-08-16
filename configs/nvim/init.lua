--[[
nix packages needed:
ripgrep
gcc
tree-sitter
stylua
lua-language-server
]]

vim.loader.enable() -- lua modules caching

local au = vim.api.nvim_create_autocmd
local aug = vim.api.nvim_create_augroup

local function gh(repo) return 'https://github.com/' .. repo end

vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Behavior
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.scrolloff = 4
vim.o.sidescrolloff = 4
vim.o.mouse = 'a'
vim.o.backupcopy = 'yes'
vim.o.undofile = true
vim.o.confirm = true
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
-- TODO: possible without autocmd?
au({ 'VimEnter', 'BufEnter' }, {
  desc = "Set 'formatoptions' for every buffer",
  group = aug('formatoptions', {}),
  pattern = '*',
  callback = function() vim.o.formatoptions = 'njtcql' end,
})

-- GUI
vim.o.number = true
vim.o.relativenumber = true
vim.o.laststatus = 3
vim.o.showmode = false
vim.o.cursorline = true
vim.o.wrap = false
vim.o.breakindent = true
vim.opt.shortmess:append { s = true, I = true, c = true }
au('TextYankPost', {
  desc = 'Highlight yanked text',
  group = aug('highlight-yank', {}),
  pattern = '*',
  callback = function() vim.hl.on_yank() end,
})

-- Virtual text
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.inccommand = 'split'

-- Tabs
vim.o.shiftwidth = 2 -- spaces inserted by tabs and shift operations
vim.o.softtabstop = -1
vim.o.expandtab = true

-- Terminal buffers
au({ 'BufWinEnter', 'WinEnter', 'TermOpen' }, {
  desc = 'Start insert mode when entering terminal buffer',
  group = aug('term', {}),
  pattern = 'term://*',
  command = 'startinsert',
})
au('BufLeave', {
  desc = 'Stop insert mode when leaving terminal buffer',
  group = aug('term', {}),
  pattern = 'term://*',
  command = 'stopinsert',
})

-- Keymaps
vim.keymap.set('n', '<c-h>', '<c-w><c-h>', { desc = 'Focus left' })
vim.keymap.set('n', '<c-l>', '<c-w><c-l>', { desc = 'Focus right' })
vim.keymap.set('n', '<c-j>', '<c-w><c-j>', { desc = 'Focus down' })
vim.keymap.set('n', '<c-k>', '<c-w><c-k>', { desc = 'Focus up' })

vim.keymap.set('n', '<c-up>', '<cmd>resize +2<cr>', { desc = 'Resize taller' })
vim.keymap.set(
  'n',
  '<c-down>',
  '<cmd>resize -2<cr>',
  { desc = 'Resize shorter' }
)
vim.keymap.set(
  'n',
  '<c-left>',
  '<cmd>vertical resize -2<cr>',
  { desc = 'Resize narrower' }
)
vim.keymap.set(
  'n',
  '<c-left>',
  '<cmd>vertical resize +2<cr>',
  { desc = 'Resize wider' }
)

vim.keymap.set(
  't',
  '<esc><esc>',
  '<c-\\><c-n>',
  { desc = 'Exit terminal mode' }
)

vim.keymap.set(
  'n',
  '<leader>q',
  vim.diagnostic.setloclist,
  { desc = 'Open diagnostic quickfix list' }
)

vim.keymap.set(
  'v',
  '<',
  '<gv',
  { desc = 'Re-select previous area after shift operation' }
)
vim.keymap.set(
  'v',
  '>',
  '>gv',
  { desc = 'Re-select previous area after shift operation' }
)

vim.keymap.set(
  'n',
  '<leader>oo',
  '<cmd>setlocal spell! spelllang=en,da<cr>',
  { desc = 'Toggle spell check' }
)
vim.keymap.set(
  'n',
  '<leader>oe',
  '<cmd>setlocal spelllang=en<cr>',
  { desc = 'Enable spell check - English (US)' }
)
vim.keymap.set(
  'n',
  '<leader>od',
  '<cmd>setlocal spelllang=da<cr>',
  { desc = 'Enable spell check - Danish' }
)

-- Mini modules
vim.pack.add { gh 'nvim-mini/mini.nvim' }

-- Colorscheme
vim.pack.add { { src = (gh 'catppuccin/nvim'), name = 'catppuccin' } }
require('catppuccin').setup { no_italic = true }
vim.cmd.colorscheme 'catppuccin'

-- Comments
vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }
vim.pack.add { gh 'joosepalviste/nvim-ts-context-commentstring' }
require('ts_context_commentstring').setup { enable_autocmd = false }
vim.pack.add { gh 'numtostr/comment.nvim' }
---@diagnostic disable-next-line: missing-fields
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

-- Guess indentation
vim.pack.add { gh 'nmac427/guess-indent.nvim' }
require('guess-indent').setup {}

-- Git
vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Pairs
require('mini.pairs').setup()
require('mini.surround').setup()

-- Picker
require('mini.icons').setup()
require('mini.pick').setup {
  -- Centered popup
  window = {
    config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
}
vim.keymap.set(
  'n',
  '<leader>sf',
  MiniPick.builtin.files,
  { desc = 'Search files' }
)
vim.keymap.set(
  'n',
  '<leader>sg',
  MiniPick.builtin.grep_live,
  { desc = 'Search for pattern' }
)
vim.keymap.set(
  'n',
  '<leader>sh',
  MiniPick.builtin.help,
  { desc = 'Search help' }
)

-- Statusline
require('mini.statusline').setup()

-- Formatting
vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback',
  },
  formatters_by_ft = {
    lua = { 'stylua' },
  },
}
vim.keymap.set(
  'n',
  '<leader>f',
  function() require('conform').format { async = true } end,
  { desc = 'Format buffer' }
)

-- Treesitter
vim.pack.add { gh 'nvim-treesitter/nvim-treesitter' }
-- INFO: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/SUPPORTED_LANGUAGES.md
require('nvim-treesitter').install {
  'bash',
  'css',
  'fsharp',
  'html',
  'ini',
  'java',
  'javascript',
  'json',
  'latex',
  'lua',
  'markdown',
  'nix',
  'python',
  'qmljs',
  'regex',
  'scss',
  'toml',
  'typescript',
  'typst',
  'yaml',
  'zsh',
}

-- LSP
vim.pack.add { gh 'neovim/nvim-lspconfig' }

---@type table<string, vim.lsp.Config>
local servers = {
  lua_ls = {
    on_init = function(client)
      client.server_capabilities.documentFormattingProvider = false

      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if
          path ~= vim.fn.stdpath 'config'
          and (
            vim.uv.fs_stat(path .. '/.luarc.json')
            or vim.uv.fs_stat(path .. '/.luarc.jsonc')
          )
        then
          return
        end
      end

      local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
      client.config.settings.Lua =
        vim.tbl_deep_extend('force', current_settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file('', true),
          },
        })
    end,
    ---@type lspconfig.settings.lua_ls
    settings = { Lua = { format = { enable = false } } },
  },
}

for name, server in pairs(servers) do
  vim.lsp.config(name, server)
  vim.lsp.enable(name)
end

au('LspAttach', {
  group = aug('lsp-attach', {}),
  callback = function(event)
    vim.keymap.set(
      'n',
      '<leader>rn',
      vim.lsp.buf.rename,
      { buffer = event.buf, desc = 'LSP: Rename' }
    )
    vim.keymap.set(
      'n',
      '<leader>gD',
      vim.lsp.buf.declaration,
      { buffer = event.buf, desc = 'LSP: Goto declaration' }
    )
  end,
})
