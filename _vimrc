source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin
colorscheme molokai

set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

call pathogen#infect() 
set diffexpr=MyDiff()
set number
" ��ʾ��ɫ
set t_Co=256
set laststatus=2 
set sw=4
set ts=4
set expandtab
set autoindent
" ����tabline
let g:airline#extensions#tabline#enabled = 1
" tabline�е�ǰbuffer���˵ķָ��ַ�
let g:airline#extensions#tabline#left_sep = ' '
" tabline��δ����buffer���˵ķָ��ַ�
let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline��buffer��ʾ���
let g:airline#extensions#tabline#buffer_nr_show = 1
map <F3> :NERDTreeMirror<CR>
map <F3> :NERDTreeToggle<CR>
set cursorcolumn
set cursorline
let mapleader=','
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
"�趨���Ų�ȫ
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
"�������ź���
func SkipPair()  
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'  
        return "\<ESC>la"  
    else  
        return "\t"  
    endif  
endfunc  
" ��tab����Ϊ��������  
inoremap <TAB> <c-r>=SkipPair()<CR>
"�س����Ŵ���
func SkipCRPair()  
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'  
        return "\<CR>\<ESC>O"  
    else  
        return "\<CR>"  
    endif  
endfunc  
" ��tab����Ϊ��������  
inoremap <CR> <c-r>=SkipCRPair()<CR>
