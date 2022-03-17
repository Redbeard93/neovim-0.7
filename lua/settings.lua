-- 文件编码格式
vim.opt.fileencoding = "utf-8"
-- 显示行号
vim.opt.number=true
-- tab=4个空格
vim.opt.tabstop=4
vim.opt.shiftwidth=4
-- 自动缩进的策略为 plugin
vim.o.filetype = "plugin"
-- 是否特殊显示空格等字符
vim.o.list = true
vim.cmd([[
"Basics
"去掉NonText和EndOfBuffer的~标志nvim only
set fillchars=eob:\ ,fold:\ ,vert:\|
" 设定在无操作时，交换文件刷写到磁盘的等待毫秒数（默认为 4000）
set updatetime =100
" 设定等待按键时长的毫秒数
set timeoutlen =500
set termguicolors
set path=.,**
set suffixesadd=.java
set exrc
set nocompatible
set backspace=indent,eol,start
set hidden
set expandtab
set smartindent
set nowrap
set incsearch
set clipboard+=unnamedplus
set softtabstop=4
set autoindent
set relativenumber
set textwidth=80
set history =1000
set colorcolumn=80
set scrolloff=8
set signcolumn=yes
set cuc cul
set wildmenu
set wildmode=longest,list,full
set ignorecase
set showcmd

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Undo settings

silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
    set undofile
    set undodir=~/.config/nvim/tmp/undo,.
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ColorScheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Version 1 cyberpunk high contrast scheme
highlight Cursor guibg=#9E619E guifg=#619E9E
highlight ModeMsg guibg=NONE guifg=#619E9E
highlight Search guibg=#619E9E guifg=#9E619E
highlight IncSearch guibg=#9E619E guifg=#619E9E
highlight WildMenu guibg=#9E619E guifg=#619E9E
highlight Normal ctermbg=NONE guibg=NONE
highlight Pmenu cterm=bold gui=bold ctermbg=NONE guibg=NONE
highlight StatusLine ctermbg=NONE guibg=#100D23 guifg=#9E619E
highlight StatusLineNC ctermbg=NONE guibg=#100D23 guifg=#9E619E
highlight TabLineSel gui=bold ctermbg=NONE guibg=#9E619E guifg=#100D23
highlight TabLineFill ctermbg=NONE guibg=#372963 guifg=#619E9E
highlight TabLine gui=NONE ctermbg=NONE guibg=#619E9E guifg=#372963
"highlight LineNr cterm=italic ctermbg=NONE guibg=NONE ctermfg=DarkMagenta guifg=NONE
highlight LineNrBelow cterm=italic gui=italic ctermbg=NONE guibg=NONE ctermfg=DarkMagenta guifg=#619E9E
highlight LineNrAbove cterm=italic gui=italic ctermbg=NONE guibg=NONE ctermfg=DarkCyan guifg=#9E619E
highlight CursorLineNr cterm=bold gui=bold ctermbg=NONE guibg=NONE ctermfg=LightYellow guifg=#9E9E61
highlight ColorColumn ctermbg=Black guibg=#100D23
highlight SignColumn ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
highlight CursorLine cterm=bold gui=bold ctermbg=NONE guibg=NONE
highlight CursorColumn cterm=bold gui=bold ctermbg=NONE guibg=NONE
highlight VertSplit cterm=NONE gui=NONE guifg=#9E9E61
]])
