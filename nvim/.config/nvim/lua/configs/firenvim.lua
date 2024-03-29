vim.cmd [[
function! s:IsFirenvimActive(event) abort
    if !exists('*nvim_get_chan_info')
        return 0
    endif
    let l:ui = nvim_get_chan_info(a:event.chan)
    return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
        \ l:ui.client.name =~? 'Firenvim'
endfunction

function! OnUIEnter(event) abort
    if s:IsFirenvimActive(a:event)
        set laststatus=0
    endif
endfunction

autocmd UIEnter * call OnUIEnter(deepcopy(v:event))

let g:firenvim_config = {
    \ 'globalSettings': {
        \ 'alt': 'all',
    \ },
    \ 'localSettings': {
        \ '.*': {
            \ 'cmdline': 'neovim',
            \ "content": 'text',
            \ 'priority': 0,
            \ 'selector': 'textarea',
            \ 'takeover': 'never',
        \ },
    \ },
\ }
]]
