set number rnu
let g:mapleader = ","
filetype plugin on
filetype indent on
set tabstop=4
set softtabstop=4
set shiftwidth=4
set textwidth=79
set expandtab
set autoindent
set showmatch
set cursorline
hi CursorLine ctermbg=Black cterm=bold
set path+=** "fuzzy
set wildmenu
set hlsearch
set ignorecase
set smartcase
syntax on

"file browsing
let g:netrw_banner=0
let g:netrw_browse_split=4
let g:netrw_altv=0
let g:netrw_liststyles=3
let g:netrw_winsize=25
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"  autocmd VimEnter <C-w>l
"augroup END

inoremap <A-h> <C-o>h
inoremap <A-j> <C-o>j
inoremap <A-k> <C-o>k
inoremap <A-l> <C-o>l
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\
