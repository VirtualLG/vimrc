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
" => vim visual multi config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_plugin_vm()
        let g:VM_mouse_mappings    = 1
        let g:VM_theme             = 'iceblue'
        let g:VM_highlight_matches = 'underline'
        let g:VM_leader            = ',,'
        let g:VM_maps              = {}
        let g:VM_maps["Undo"]      = 'u'
        let g:VM_maps["Redo"]      = '<C-r>'
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
        Plug 'tpope/vim-commentary'
        Plug 'drmikehenry/vim-fixkey'

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
        call s:configure_plugin_vm()
        call s:configure_plugin_supertab()
        call s:configure_plugin_ycm()
endfunction


" ----------------------------------------------------------------------
"  Util funcs
" ----------------------------------------------------------------------

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_vim_general()
        " Sets how many lines of history VIM has to remember
        set history=500

        " Enable filetype plugins
        filetype plugin on
        filetype indent on

        " Set to auto read when a file is changed from the outside
        set autoread
        au FocusGained,BufEnter * checktime

        " With a map leader it's possible to do extra key combinations
        " like <leader>w saves the current file
        let g:mapleader = ","

        " Fast saving
        nmap <leader>w :w!<cr>

        " :W sudo saves the file
        " (useful for handling the permission-denied error)
        command! W execute 'w !sudo tee % > /dev/null' <bar> edit!

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " => Files and backups
        " Turn backup off, since most stuff is in SVN, git etc. anyway...
        set nobackup
        set nowb
        set noswapfile

        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
        " => Text, tab and indent related
        " Be smart when using tabs ;)
        set smarttab

        " 1 tab == 8 spaces
        set shiftwidth=8
        set tabstop=8

        " Linebreak on 500 characters
        set lbr
        set tw=500

        set ai "Auto indent
        set si "Smart indent
        set wrap "Wrap lines

        " Always show the status line
        set laststatus=2

endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_vim_ui()
        " Set 7 lines to the cursor - when moving vertically using j/k
        set so=7

        " Avoid garbled characters in Chinese language windows OS
        let $LANG='en'
        set langmenu=en
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim

        " Turn on the Wild menu
        set wildmenu

        " Ignore compiled files
        set wildignore=*.o,*~,*.pyc
        if has("win16") || has("win32")
            set wildignore+=.git\*,.hg\*,.svn\*
        else
            set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
        endif

        " Always show current position
        set ruler

        " Height of the command bar
        set cmdheight=1

        " A buffer becomes hidden when it is abandoned
        set hid

        " Configure backspace so it acts as it should act
        set backspace=eol,start,indent
        set whichwrap+=<,>,h,l

        " Ignore case when searching
        set ignorecase

        " When searching try to be smart about cases
        set smartcase

        " Highlight search results
        set hlsearch

        " Makes search act like search in modern browsers
        set incsearch

        " Don't redraw while executing macros (good performance config)
        set lazyredraw

        " For regular expressions turn magic on
        set magic

        " Show matching brackets when text indicator is over them
        set showmatch

        " How many tenths of a second to blink when matching brackets
        set mat=2

        " No annoying sound on errors
        set noerrorbells
        set novisualbell
        set t_vb=
        set tm=500

        " Properly disable sound on errors on MacVim
        if has("gui_macvim")
            autocmd GUIEnter * set vb t_vb=
        endif

        " Add a bit extra margin to the left
        set foldcolumn=1

        " Set font according to system
        if has("mac") || has("macunix")
            set gfn=IBM\ Plex\ Mono:h14,Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
        elseif has("win16") || has("win32")
            set gfn=IBM\ Plex\ Mono:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
        elseif has("gui_gtk2")
            set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
        elseif has("linux")
            set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
        elseif has("unix")
            set gfn=Monospace\ 11
        endif

        " Disable scrollbars (real hackers don't use scrollbars for navigation!)
        set guioptions-=r
        set guioptions-=R
        set guioptions-=l
        set guioptions-=L
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! s:configure_vim_colors_and_fonts()
        " Enable syntax highlighting
        syntax enable

        " Enable 256 colors palette in Gnome Terminal
        if $COLORTERM == 'gnome-terminal'
            set t_Co=256
        endif


        " Colorscheme
        try
            colorscheme desert
        catch
        endtry

        set background=dark

        " Set extra options when running in GUI mode
        if has("gui_running")
            set guioptions-=T
            set guioptions-=e
            set t_Co=256
            set guitablabel=%M\ %t
        endif

        " Set utf8 as standard encoding and en_US as the standard language
        set encoding=utf8

        " Use Unix as the standard file type
        set ffs=unix,dos,mac

endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tricks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Return to last edit position when opening files (You want this!)
function! s:configure_vim_tricks()
        au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

        " Remove the Windows ^M - when the encodings gets messed up
        noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

        " Quickly open a buffer for scribble
        map <leader>q :e ~/buffer<cr>

        " Quickly open a markdown buffer for scribble
        map <leader>x :e ~/buffer.md<cr>

        " Toggle paste mode on and off
        map <leader>pp :setlocal paste!<cr>

        " Fast editing and reloading of vimrc configs
        map <leader>e :e! ~/.vim/my_configs.vim<cr>
        autocmd! bufwritepost ~/.vim/my_configs.vim source ~/.vim/my_configs.vim

        " => Turn persistent undo on
        "    means that you can undo even when you close a buffer/VIM
        try
            set undodir=~/.vim/temp_dirs/undodir
            set undofile
        catch
        endtry




endfunction

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
function ToggleQuickFix()
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
        call s:configure_vim_general()
        call s:configure_vim_ui()
        call s:configure_vim_colors_and_fonts()
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

        " Smart way to move between windows
        map <C-j> <C-W>j
        map <C-k> <C-W>k
        map <C-h> <C-W>h
        map <C-l> <C-W>l

        " Disable highlight when <leader><cr> is pressed
        map <silent> <leader><cr> :noh<cr>

        " Close the current buffer
        map <leader>bd :Bclose<cr>:tabclose<cr>gT

        " Close all the buffers
        map <leader>ba :bufdo bd<cr>

        map <leader>l :bnext<cr>
        map <leader>h :bprevious<cr>

        " Useful mappings for managing tabs
        map <leader>tn :tabnew<cr>
        map <leader>to :tabonly<cr>
        map <leader>tc :tabclose<cr>
        map <leader>tm :tabmove
        map <leader>t<leader> :tabnext

        " Let 'tl' toggle between this and the last accessed tab
        let g:lasttab = 1
        nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
        au TabLeave * let g:lasttab = tabpagenr()


        " Opens a new tab with the current buffer's path
        " Super useful when editing files in the same directory
        map <leader>te :tabedit <C-r>=expand("%:p:h")<cr>/

        " Switch CWD to the directory of the open buffer
        map <leader>cd :cd %:p:h<cr>:pwd<cr>

        " Specify the behavior when switching between buffers
        try
          set switchbuf=useopen,usetab,newtab
          set stal=2
        catch
        endtry

        " Remap VIM 0 to first non-blank character
        map 0 ^

        " Move a line of text using ALT+[jk] or Command+[jk] on mac
        nmap <M-j> mz:m+<cr>`z
        nmap <M-k> mz:m-2<cr>`z
        vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
        vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

        if has("mac") || has("macunix")
          nmap <D-j> <M-j>
          nmap <D-k> <M-k>
          vmap <D-j> <M-j>
          vmap <D-k> <M-k>
        endif

        " Delete trailing white space on save, useful for some filetypes ;)
        fun! CleanExtraSpaces()
            let save_cursor = getpos(".")
            let old_query = getreg('/')
            silent! %s/\s\+$//e
            call setpos('.', save_cursor)
            call setreg('/', old_query)
        endfun

        if has("autocmd")
            autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
        endif

        " => Spell checking
        " Pressing ,ss will toggle and untoggle spell checking
        map <leader>ss :setlocal spell!<cr>

        " Shortcuts using <leader>
        map <leader>sn ]s
        map <leader>sp [s
        map <leader>sa zg
        map <leader>s? z=

        " => Command mode related
        " Smart mappings on the command line
        cno $h e ~/
        cno $d e ~/Desktop/
        cno $j e ./
        cno $c e <C-\>eCurrentFileDir("e")<cr>

        " $q is super useful when browsing on the command line
        " it deletes everything until the last slash
        cno $q <C-\>eDeleteTillSlash()<cr>

        " Bash like keys for the command line
        cnoremap <C-A>		<Home>
        cnoremap <C-E>		<End>
        cnoremap <C-K>		<C-U>

        cnoremap <C-P> <Up>
        cnoremap <C-N> <Down>

        " Map ½ to something useful
        map ½ $
        cmap ½ $
        imap ½ $

        " 26/08/22 20:03:55, input 'xdate' in insert mode
        iab xdate <C-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

        " compile && run
        map <F5> :call CompileRun()<CR>
        imap <F5> <Esc>:call CompileRun()<CR>
        vmap <F5> <Esc>:call CompileRun()<CR>

endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif

    return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
    return a:cmd . " " . expand("%:p:h") . "/"
endfunc

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!gcc % -o %<"
    exec "!time ./%<"
elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %"
elseif &filetype == 'sh'
    exec "!time bash %"
elseif &filetype == 'python'
    exec "!time python3 %"
elseif &filetype == 'html'
    exec "!google-chrome % &"
elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
elseif &filetype == 'matlab'
    exec "!time octave %"
endif
endfunc


" ----------------------------------------------------------------------
"  Main Routine
" ----------------------------------------------------------------------
call s:utils_func_main()
call s:configure_plugins()
call s:configure_global_mappings()


"------------------------------------------------- => File type related
" => Python section
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return
au FileType python inoremap <buffer> $i import
au FileType python inoremap <buffer> $p print
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class
au FileType python map <buffer> <leader>2 /def
au FileType python map <buffer> <leader>C ?class
au FileType python map <buffer> <leader>D ?def

" => JavaScript section
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript,typescript imap <C-t> console.log();<esc>hi
au FileType javascript,typescript imap <C-a> alert();<esc>hi

au FileType javascript,typescript inoremap <buffer> $r return
au FileType javascript,typescript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


" => CoffeeScript section
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])

" => Shell section
if exists('$TMUX')
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color
    endif
endif

" => Twig section
autocmd BufRead *.twig set syntax=html filetype=html

" => Markdown
let vim_markdown_folding_disabled = 1
