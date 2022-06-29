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
endfunction

call s:configure_plugins()
