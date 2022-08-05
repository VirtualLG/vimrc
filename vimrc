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
        let g:MRU_Max_Entries = 400
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy the link to the line of a Git repository to the clipboard
function! s:configure_plugin_fugitive()
        nnoremap <leader>v :.GBrowse!<CR>
        xnoremap <leader>v :'<'>GBrowse!<CR>
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_gitgutter()
        let g:gitgutter_enabled=0
        nnoremap <silent> <leader>d :GitGutterToggle<cr>
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_fzf()
        set rtp+=~/.fzf

        nmap <C-p> :FZF<CR>
        nmap <C-m> :Buffers<CR>
        " Mapping selecting mappings
        nmap <leader><tab> <plug>(fzf-maps-n)
        xmap <leader><tab> <plug>(fzf-maps-x)
        omap <leader><tab> <plug>(fzf-maps-o)

        " Insert mode completion
        imap <c-x><c-k> <plug>(fzf-complete-word)
        imap <c-x><c-f> <plug>(fzf-complete-path)
        imap <c-x><c-l> <plug>(fzf-complete-line)

        " Path completion with custom source command
        inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
        inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')

        " Word completion with custom spec with popup layout option
        inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => gtags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_gtags()
        let $GTAGSLABEL = 'native-pygments'
        let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

        set cscopetag " 使用 cscope 作为 tags 命令

        "gtags-cscope.vim 设置项
        let g:GtagsCscope_Auto_Load = 1
        let g:GtagsCscope_Ignore_Case = 1
        let g:GtagsCscope_Auto_Map = 1
        let g:GtagsCscope_Quiet = 1
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => molokai
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_molokai()
        let g:molokai_original = 1
        let g:rehash256 = 1

        " Colorscheme
        set background=dark
        colorscheme molokai
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_tagbar()
        let g:tagbar_autoshowtag = 1          "当编辑代码时，在Tagbar自动追踪变量
        let g:tagbar_iconchars = ['▸', '▾']   " 个人爱好，展开关闭文件夹的图标
        let g:tagbar_left = 1                 " 配置tagbar窗口位于左侧

        " tagbar mapping
        nmap <F2> :TagbarToggle<cr>
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-easymotion
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_easymotion()
        let g:EasyMotion_smartcase = 1

        map <Space> <Plug>(easymotion-overwin-f2)
        map <Space>h <Plug>(easymotion-linebackward)
        map <Space>j <Plug>(easymotion-j)
        map <Space>k <Plug>(easymotion-k)
        map <Space>l <Plug>(easymotion-lineforward)
        map <Space>. <Plug>(easymotion-repeat)
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-signify
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_signify()
        set updatetime=100
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-polyglot
"""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:preconfigure_plugin_polyglot()
        let g:polyglot_disabled = ['sensible']
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-tmux-navigator
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_tmux_navigator()
        " actions while navigator to other tmux panes
        " 1: update, write current buffer, but only if changed
        " 2: wall, write all buffers
        let g:tmux_navigator_save_on_switch = 2
        let g:tmux_navigator_no_mappings = 0
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_vim_surround()
        " fake function, never be called, just for note
        " cs"]    |     change surrounding
        " cs]{    |     change surroouding, {  } 内部带空格
        " cs]}    |     change surrounding, {} 内部不带空格
        " ds"     |     delete surrounding
        " ysiw]   |     add surrounding in word
        " yssb    |     为整行添加 surrounding
        " yss]    |     为整行添加 surrounding
        " S       |     Visual 模式下，添加 surrounding
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => supertab for ultisnips and ycm work together
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_supertab()
        " make YCM compatible with UltiSnips (using supertab)
        let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
        let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
        let g:SuperTabDefaultCompletionType = '<C-n>'

        " better key bindings for UltiSnipsExpandTrigger
        let g:UltiSnipsExpandTrigger = "<tab>"
        let g:UltiSnipsJumpForwardTrigger = "<tab>"
        let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompleteMe config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_ycm()
        " ----------------------
        " install
        " ----------------------
        " python3 install.py --clangd-completer   编译安装 ycm, 支持类 C 语言
        " python3 install.py --cs-completer       编译安装 ycm, 支持 #
        " python3 install.py --go-completer       编译安装 ycm, 支持 go
        " python3 install.py --ts-completer       编译安装 ycm, 支持 JavaScript 和 TypeScript，
        "                                                需要安装 Node.js 和 npm
        " python3 install.py --rust-completer     编译安装 ycm, 支持 Rust
        " python3 install.py --java-completer     编译安装 ycm, 支持 Java
        "                                                需要安装 JDK
        " python3 install.py --all                编译安装 ycm, 支持以上所有语言包

        " ----------------------
        " 语法高亮
        " ----------------------
        let g:ycm_enable_semantic_highlighting=1
        let MY_YCM_HIGHLIGHT_GROUP = {
              \   'typeParameter': 'PreProc',
              \   'parameter': 'Normal',
              \   'variable': 'Normal',
              \   'property': 'Normal',
              \   'enumMember': 'Normal',
              \   'event': 'Special',
              \   'member': 'Normal',
              \   'method': 'Normal',
              \   'class': 'Special',
              \   'namespace': 'Special',
        \ }

        for tokenType in keys( MY_YCM_HIGHLIGHT_GROUP )
          call prop_type_add( 'YCM_HL_' . tokenType,
                    \ { 'highlight': MY_YCM_HIGHLIGHT_GROUP[ tokenType ] } )
        endfor

        " ----------------------
        " 其他配置
        " ----------------------
        let ycm_conf = getcwd() . "/.ycm_extra_conf.py"
        if filereadable(ycm_conf)
                let g:ycm_global_ycm_extra_conf = ycm_conf
        else
                let g:ycm_global_ycm_extra_conf = "~/.vim/ycm_conf/ycm_extra_conf.py"
        endif
        let g:ycm_min_num_of_chars_for_completion = 1      " 输入一个字符后就开始联想补全
        let g:ycm_complete_in_comments = 1                 " 补全功能在注释中生效
        let g:ycm_confirm_extra_conf=0                     " 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示"
        let g:ycm_seed_identifiers_with_syntax = 1         " 补全语法关键字
        let g:ycm_collect_identifiers_from_tags_files = 1  " 补全引擎包含tag文件
endfunction


"   For the vim scripts manager --- vim plug
" -----------------------------------------------------------------------
function! s:configure_plugins()
        " Plugins directory
        call plug#begin('~/.vim/plugins')

        " Pre configs for the plugins
        call s:preconfigure_plugin_polyglot()

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
        Plug 'terryma/vim-expand-region'
        Plug 'tpope/vim-fugitive'
        Plug 'airblade/vim-gitgutter'
        Plug 'junegunn/fzf.vim'
        Plug 'preservim/tagbar'
        Plug 'easymotion/vim-easymotion'
        Plug 'mhinz/vim-signify'
        Plug 'sheerun/vim-polyglot'
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'lfv89/vim-interestingwords'
        Plug 'tpope/vim-surround'
        Plug 'tpope/vim-repeat'
        Plug 'farmergreg/vim-lastplace'
        Plug 'mg979/vim-visual-multi', {'branch': 'master'}
        Plug 'nvie/vim-flake8'
        Plug 'ervandew/supertab'
        Plug 'ycm-core/YouCompleteMe'
        Plug 'SirVer/ultisnips'
        Plug 'honza/vim-snippets'

	" Themes
        Plug 'morhetz/gruvbox'
        Plug 'tomasr/molokai'

        call plug#end()

        " Additional configs for the plugins
        call s:configure_plugin_ack()
        call s:configure_plugin_ale()
        call s:configure_plugin_bufExp()
        call s:configure_plugin_MRU()
        call s:configure_plugin_NerdTree()
        call s:configure_plugin_lightline()
        call s:configure_plugin_tabular()
        call s:configure_plugin_fugitive()
        call s:configure_plugin_gitgutter()
        call s:configure_plugin_fzf()
        call s:configure_plugin_gtags()
        call s:configure_plugin_molokai()
        call s:configure_plugin_tagbar()
        call s:configure_plugin_easymotion()
        call s:configure_plugin_signify()
        call s:configure_plugin_tmux_navigator()
        call s:configure_plugin_supertab()
        call s:configure_plugin_ycm()
endfunction


" ----------------------------------------------------------------------
"  Util funcs
" ----------------------------------------------------------------------


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search the "GTAGS"
" 1. 先当前路径下找 "GTAGS", 然后依次往上级目录找
""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:set_proj_root()
        " Step1: find GTAGS in the current working directory and upper
        " directory.
        let tags_db = findfile("GTAGS", ".;")
        let tags_path = ""
        if (!empty(tags_db) && filereadable(tags_db))
        let tags_path = strpart(tags_db, 0, match(tags_db, "/GTAGS$"))
        endif

        if tags_path != ""
                exe "chdir " . tags_path
        endif
endfunction


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle Quick Fix Window
""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Utils main
""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:utils_func_main()
        " get proj root by GTAGS file
        call s:set_proj_root()
endfunction

" ----------------------------------------------------------------------
"  Key Mappings
" ----------------------------------------------------------------------
function! s:configure_global_mappings()
        " paster from register 0
        map <Space>p "0p

        " Use <F4> to toggle quick fix window
        nnoremap <silent> <F4> :call ToggleQuickFix()<cr>
endfunction


" ----------------------------------------------------------------------
"  Main Routine
" ----------------------------------------------------------------------
call s:utils_func_main()
call s:configure_plugins()
call s:configure_global_mappings()
