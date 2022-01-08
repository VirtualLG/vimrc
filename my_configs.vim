" 默认显示行号及相对行号
set nu
set rnu

" 保存时，自动删除行尾空格
autocmd BufWritePre * :%s/\s\+$//e

" vim默认会把以0开头的数字，识别为8进制数
" 使用以下配置，告诉vim，把所有数字都当成十进制
set nrformats=

:hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
:hi TabLine ctermfg=Blue ctermbg=Yellow
:hi TabLineSel ctermfg=Red ctermbg=Yellow

"####################################### tab switch
nnoremap H gT
nnoremap L gt

"####################################### NerdTree
"let g:NERDTreeWinPos = "left"
"去除第一行的帮助提示
let NERDTreeMinimalUI=1
wincmd l
let NERDTreeDirArrows=1

"打开vim时自动打开
"autocmd VimEnter * NERDTree | wincmd p
"autocmd BufWinEnter * NERDTreeMirror

"<F3>作为toggle
nmap <F3> :NERDTreeToggle<CR>
"当所有文件关闭时，关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"nerdtree sync
let g:nerdtree_sync_cursorline=1

"打开新buffer时，退出nerdtree
let NERDTreeQuitOnOpen=1

"Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer=1

"########################################TagBar
"在这儿设定二者的分布
"let g:tagbar_vertical = 25
"去除第一行的帮助信息
"let g:tagbar_compact = 1
"当编辑代码时，在Tagbar自动追踪变量
let g:tagbar_autoshowtag = 1
"个人爱好，展开关闭文件夹的图标
let g:tagbar_iconchars = ['▸', '▾']
"<F2>作为toggle
nmap <F2> :TagbarToggle<CR>
"打开vim时自动打开
"autocmd VimEnter * nested :TagbarOpen
"wincmd l
"如果不加这句，打开vim的时候当前光标会在Nerdtree区域
"autocmd VimEnter * wincmd l
"配置tagbar窗口位于左侧
let g:tagbar_left = 1

"########################################Toggle window fullscreen
function! Zoom ()
    " check if is the zoomed state (tabnumber > 1 && window == 1)
    if tabpagenr('$') > 1 && tabpagewinnr(tabpagenr(), '$') == 1
        let l:cur_winview = winsaveview()
        let l:cur_bufname = bufname('')
        tabclose

        " restore the view
        if l:cur_bufname == bufname('')
            call winrestview(cur_winview)
        endif
    else
        tab split
    endif
endfunction

nmap <leader>z :call Zoom()<CR>

"######################################### GNU Global
set cscopetag " 使用 cscope 作为 tags 命令
set cscopeprg='gtags-cscope' " 使用 gtags-cscope 代替 cscope


"gtags.vim 设置项
let GtagsCscope_Auto_Load = 1
let GtagsCscope_Ignore_Case = 1
let GtagsCscope_Auto_Map = 1
let GtagsCscope_Quiet = 1

"######################################### fzf
set rtp+=~/.fzf

"######################################### AutoHighlight, when idle
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     echo 'Highlight current word: off'
     return 0
  else
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
  return 1
 endif
endfunction

nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

"######################################### molokai color scheme
let g:molokai_original = 1
let g:rehash256 = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""
" youcompleteme with SuperTab
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_global_ycm_extra_conf = '~/.vim_runtime/my_plugins/youcompleteme/third_party/ycmd/.ycm_extra_conf.py'

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" 代码提示框的高亮配置
highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

let g:ycm_show_diagnostics_ui = 1                  " 关闭语法提示
let g:ycm_complete_in_comments=1                   " 补全功能在注释中同样有效
let g:ycm_collect_identifiers_from_tags_files=1    " 开启 YCM 标签补全引擎
let g:ycm_min_num_of_chars_for_completion=2        " 从第二个键入字符开始罗列匹配项
let g:ycm_cache_omnifunc=0                         " 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1           " 语法关键字补全
let g:ycm_key_invoke_completion="<c-right>"

"""""""""""""""""""""""""""""""""""""""""""""""""""
" UltiSnips
"""""""""""""""""""""""""""""""""""""""""""""""""""
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsSnippetsDir="~/.vim_runtime/my_plugins/ultisnips"
let g:UltiSnipsEditSplit="vertical"
