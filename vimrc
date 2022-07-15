"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ack searching and cope displaying
"    requires ack.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_ack()
        " Use the the_silver_searcher if possible (much faster than Ack)
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale (syntax checker and linter)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_ale()
        let g:ale_linters = {
        \   'javascript': ['eslint'],
        \   'python': ['flake8'],
        \   'go': ['go', 'golint', 'errcheck']
        \}

        nmap <silent> <leader>a <Plug>(ale_next_wrap)

        " Disabling highlighting
        let g:ale_set_highlights = 0

        " Only run linting when saving the file
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_enter = 0
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_bufExp()
        let g:bufExplorerDefaultHelp=0
        let g:bufExplorerShowRelativePath=1
        let g:bufExplorerFindActive=1
        let g:bufExplorerSortBy='name'
        map <leader>b :BufExplorer<cr>
endfunction


""""""""""""""""""""""""""""""
" => MRU plugin
""""""""""""""""""""""""""""""
function! s:configure_plugin_MRU()
        let MRU_Max_Entries = 400
        map <leader>f :MRU<CR>
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_NerdTree()
        " Nerd Tree Config
        let g:NERDTreeWinPos = "right"
        let g:NERDTreeShowHidden=1
        let g:NERDTreeIgnore = ['\.pyc$', '__pycache__']
        let g:NERDTreeWinSize=35
        let g:NERDTreeMinimalUI=1         " 去除第一行的帮助信息
        let g:NERDTreeDirArrows=1         " 显示文件夹箭头
        let g:NERDTreeQuitOnOpen=1        " 打开新buffer时，退出nerdtree
        let g:NERDTreeAutoDeleteBuffer=1  " 从NerdTree删除文件时，自动删除对应buffer

        " NerdTree Key map
        map <leader>nb :NERDTreeFromBookmark<Space>
        map <leader>nf :NERDTreeFind<cr>
        nmap <F3> :NERDTreeToggle<CR>

        " 当所有文件关闭时，关闭项目树窗格
        autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

        " NerdTree sync
        let g:nerdtree_sync_cursorline=1
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_lightline()

let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'absolutepath', 'modified'] ],
      \   'right': [ [ 'lineinfo'  ],
      \              [ 'percent'  ],
      \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex'  ] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*FugitiveHead")?FugitiveHead():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*FugitiveHead") && ""!=FugitiveHead())'
      \ },
      \ 'separator': { 'left': ' ', 'right': '😜 ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tabular
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_tabular()
        if exists(":Tabularize")
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:\zs<CR>
        vmap <Leader>a: :Tabularize /:\zs<CR>
        endif
endfunction


" -----------------------------------------------------------------------
"   For the vim scripts manager --- vim plug
" -----------------------------------------------------------------------
function! s:configure_plugins()
        " Plugins directory
        call plug#begin('~/.vim_runtime/plugins')

        " Plugins
        Plug 'mileszs/ack.vim'
        Plug 'dense-analysis/ale'
        Plug 'jiangmiao/auto-pairs'
        Plug 'jlanzarotta/bufexplorer'
        Plug 'mattn/vim-gist'
        Plug 'yegappan/mru'
        Plug 'preservim/nerdtree'
        Plug 'unkiwii/vim-nerdtree-sync'
        Plug 'Xuyuanp/nerdtree-git-plugin'
        Plug 'itchyny/lightline.vim'
        Plug 'godlygeek/tabular'

	" Themes
        Plug 'morhetz/gruvbox'

        call plug#end()

        " Additional configs for the plugins
        call s:configure_plugin_ack()
        call s:configure_plugin_ale()
        call s:configure_plugin_bufExp()
        call s:configure_plugin_MRU()
        call s:configure_plugin_NerdTree()
        call s:configure_plugin_lightline()
        call s:configure_plugin_tabular()
endfunction

call s:configure_plugins()
