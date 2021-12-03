"默认显示行号
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

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

"####################################### tab switch
nnoremap H gT
nnoremap L gt

"####################################### NerdTree
"let g:NERDTreeWinPos = "left"
"去除第一行的帮助提示
let NERDTreeMinimalUI=1
wincmd l
"
"打开vim时自动打开
autocmd VimEnter * NERDTree | wincmd p
"autocmd BufWinEnter * NERDTreeMirror

"<F3>作为toggle
nmap <F3> :NERDTreeToggle<CR>
"当所有文件关闭时，关闭项目树窗格
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" nerdtree sync
let g:nerdtree_sync_cursorline = 1

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
