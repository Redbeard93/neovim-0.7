--fat cursor
vim.opt.guicursor = ""

-- 文件编码格式
vim.opt.fileencoding = "utf-8"

-- 显示行号
vim.opt.nu = true
vim.opt.relativenumber = true

-- show cursorline & cursorcolumn
vim.opt.cul = true
vim.opt.cuc = true

-- tab=4个空格
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

-- 是否特殊显示空格等字符
vim.o.list = true

--在处理未保存或制度文件的时候，弹出确认
vim.o.confirm = true

-- No backup but can undo from days ago
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- 设定在无操作时，交换文件刷写到磁盘的等待毫秒数（默认为 4000）
vim.opt.updatetime = 50

-- 设定等待按键时长的毫秒数 leader key is ' ', so when you insert space it lags
vim.opt.timeoutlen = 100

-- 去掉NonText和EndOfBuffer的~标志nvim only
vim.opt.fillchars = { eob = ' ', fold = ' ', vert = '|' }

vim.opt.colorcolumn = "80"

vim.opt.wildmode = { 'longest', 'list', 'full' }

vim.opt.suffixesadd = ".java"

vim.opt.clipboard = "unnamedplus"

-- highlight
vim.api.nvim_set_hl(0, "Cursor", { bg = "#9E619E", fg = "#619E9E" })
vim.api.nvim_set_hl(0, "ModeMsg", { bg = "NONE", fg = "#619E9E" })
vim.api.nvim_set_hl(0, "Search", { bg = "#619E9E", fg = "#9E619E" })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#9E619E", fg = "#619E9E" })
vim.api.nvim_set_hl(0, "WildMenu", { bg = "#9E619E", fg = "#619E9E" })
vim.api.nvim_set_hl(0, "Normal", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "Pmenu", { cterm = {bold = true}, bold = true, ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "StatusLine", { ctermbg = "NONE", bg = "#100D23", fg = "#9E619E" })
vim.api.nvim_set_hl(0, "StatusLineNC", { ctermbg = "NONE", bg = "#100D23", fg = "#9E619E" })
vim.api.nvim_set_hl(0, "TabLineSel", { ctermbg = "NONE", bold = true, bg = "#9E619E", fg = "#100D23" })
vim.api.nvim_set_hl(0, "TabLineFill", { ctermbg = "NONE", bg = "#372963", fg = "#619E9E" })
vim.api.nvim_set_hl(0, "TabLine", { ctermbg = "NONE", bg = "#619E9E", fg = "#372963" })
vim.api.nvim_set_hl(0, "LineNrBelow", { cterm = {italic = true}, ctermbg = "NONE", ctermfg = "DarkMagenta", italic = true, bg = "none", fg = "#619E9E" })
vim.api.nvim_set_hl(0, "LineNrAbove", { cterm = {italic = true}, ctermbg = "NONE", ctermfg = "DarkCyan", italic = true, bg = "none", fg = "#9E619E" })
vim.api.nvim_set_hl(0, "CursorLineNr", { cterm = {bold = true}, ctermbg = "NONE", ctermfg = "LightYellow", bold = true, bg = "none", fg = "#9E9E61" })
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = "Black", bg = "#100D23" })
vim.api.nvim_set_hl(0, "SignColumn", { ctermbg = "NONE", ctermfg = "NONE", bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "CursorLine", { cterm = {bold = true}, ctermbg = "NONE", bold = true, bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "CursorColumn", { cterm = {bold = true}, ctermbg = "NONE", bold = true, bg = "NONE", fg = "NONE" })
vim.api.nvim_set_hl(0, "VertSplit", { fg = "#9E9E61" })

--vim.cmd([[
--
--""Version 1 cyberpunk high contrast scheme
--"highlight Cursor guibg=#9E619E guifg=#619E9E
--"highlight ModeMsg guibg=NONE guifg=#619E9E
--"highlight Search guibg=#619E9E guifg=#9E619E
--"highlight IncSearch guibg=#9E619E guifg=#619E9E
--"highlight WildMenu guibg=#9E619E guifg=#619E9E
--"highlight Normal ctermbg=NONE guibg=NONE
--"highlight Pmenu cterm=bold gui=bold ctermbg=NONE guibg=NONE
--"highlight StatusLine ctermbg=NONE guibg=#9E619E guifg=#100D23
--"highlight StatusLineNC ctermbg=NONE guibg=#100D23 guifg=#9E619E
--"highlight TabLineSel gui=bold ctermbg=NONE guibg=#9E619E guifg=#100D23
--"highlight TabLineFill ctermbg=NONE guibg=#372963 guifg=#619E9E
--"highlight TabLine gui=NONE ctermbg=NONE guibg=#619E9E guifg=#372963
--""highlight LineNr cterm=italic ctermbg=NONE guibg=NONE ctermfg=DarkMagenta guifg=NONE
--"highlight LineNrBelow cterm=italic gui=italic ctermbg=NONE guibg=NONE ctermfg=DarkMagenta guifg=#619E9E
--"highlight LineNrAbove cterm=italic gui=italic ctermbg=NONE guibg=NONE ctermfg=DarkCyan guifg=#9E619E
--"highlight CursorLineNr cterm=bold gui=bold ctermbg=NONE guibg=NONE ctermfg=LightYellow guifg=#9E9E61
--"highlight ColorColumn ctermbg=Black guibg=#100D23
--"highlight SignColumn ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE
--"highlight CursorLine cterm=bold gui=bold ctermbg=NONE guibg=NONE
--"highlight CursorColumn cterm=bold gui=bold ctermbg=NONE guibg=NONE
--"highlight VertSplit cterm=NONE gui=NONE guifg=#9E9E61
--
--"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--"Basics
--"去掉NonText和EndOfBuffer的~标志nvim only
--"set fillchars=eob:\ ,fold:\ ,vert:\|
--"set path=.,**
--"set suffixesadd=.java
--"set backspace=indent,eol,start "only vim need
--"set clipboard+=unnamedplus
--
--"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
--"Undo settings
--
--"silent !mkdir -p ~/.config/nvim/tmp/backup
--"silent !mkdir -p ~/.config/nvim/tmp/undo
--"set backupdir=~/.config/nvim/tmp/backup,.
--"set directory=~/.config/nvim/tmp/backup,.
--"if has('persistent_undo')
--"    set undofile
--"    set undodir=~/.config/nvim/tmp/undo,.
--"endif
--
--]])
