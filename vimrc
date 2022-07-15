"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use the the_silver_searcher if possible (much faster than Ack)
function! s:configure_plugin_ack()
	if executable('ag')
		let g:ackprg = 'ag --vimgrep --smart-case'
	endif

        " When you press gv you Ack after the selected text
        vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

        " Open Ack and put the cursor in the right position
        map <leader>g :Ack

        " When you press <leader>r you can search and replace the selected text
        vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>
        " Do :help cope if you are unsure what cope is. It's super useful!
        "
        " When you search with Ack, display your results in cope by doing:
        "   <leader>cc
        "
        " To go to the next search result do:
        "   <leader>n
        "
        " To go to the previous search results do:
        "   <leader>p
        "
        map <leader>cc :botright cope<cr>
        map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
        map <leader>n :cn<cr>
        map <leader>p :cp<cr>

        " Make sure that enter is never overriden in the quickfix window
        autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
endfunction


" -----------------------------------------------------------------------
"   For the vim scripts manager --- vim plug
" -----------------------------------------------------------------------
function! s:configure_plugins()
        " Plugins directory
        call plug#begin('~/.vim_runtime/plugins')

        " Plugins
        Plug 'mileszs/ack.vim'

	" Themes

        call plug#end()

        " Additional configs for the plugins
        call s:configure_plugin_ack()
endfunction

call s:configure_plugins()
