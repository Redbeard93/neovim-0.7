--dap 制定python解释器路径
vim.g.python_path = "/usr/bin/python3.10"

-- 自动切换输入法（fcitx5 框架）
vim.g.fcitx5ToggleInput = function()
    local input_status = tonumber(vim.fn.system("fcitx5-remote"))
    if input_status == 2 then
        vim.fn.system("fcitx5-remote -c")
    end
end

vim.cmd("autocmd InsertLeave * call fcitx5ToggleInput()")

--statusbar
vim.cmd([[
function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) >0?' '.' '.l:branchname.' ':''
endfunction
set laststatus=2
set statusline=
set statusline+=\ %{StatuslineGit()}
set statusline+=\ \ %.33F
set statusline+=\ \ \ %y
set statusline+=%=
set statusline+=\ \ \ %{strftime(\"%m-%d-%y\ %H:%M\")}\ 
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}\ 
set statusline+=\ %{&fileformat}\\ 
set statusline+=\ 錄%L\ 
set statusline+=\ \ %l\ 
set statusline+=\ \ %c\ 
set statusline+=\ ﴜ\ %p\ 
]])

-- netrw
vim.cmd([[
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

function! OpenToRight()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright vnew' g:path
	:normal <C-w>l
endfunction

function! OpenBelow()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'belowright new' g:path
	:normal <C-w>l
endfunction

function! OpenTab()
	:normal v
	let g:path=expand('%:p')
	execute 'q!'
	execute 'tabedit' g:path
	:normal <C-w>l
endfunction

function! NetrwMappings()
		" Hack fix to make ctrl-l work properly
"		noremap <buffer> <A-l> <C-w>l
"		noremap <buffer> <C-l> <C-w>l
"		noremap <silent> <leader><tab> :call ToggleNetrw()<CR>
		noremap <buffer> V :call OpenToRight()<cr>
		noremap <buffer> H :call OpenBelow()<cr>
		noremap <buffer> T :call OpenTab()<cr>
endfunction

augroup netrw_mappings
		autocmd!
		autocmd filetype netrw call NetrwMappings()
augroup END

" Allow for netrw to be toggled

function! ToggleNetrw()
		if g:NetrwIsOpen
				let i = bufnr("$")
				while (i >= 1)
						if (getbufvar(i, "&filetype") == "netrw")
								silent exe "bwipeout " . i
						endif
						let i-=1
				endwhile
				let g:NetrwIsOpen=0
		else
				let g:NetrwIsOpen=1
				silent Lexplore
		endif
endfunction

" Close Netrw if it's the only buffer open

autocmd WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&filetype") == "netrw" || &buftype == 'quickfix' |q|endif

" Check before opening buffer on any file

function! NetrwOnBufferOpen()
    if exists('b:noNetrw')
        return
    endif
    call ToggleNetrw()
endfun

" Make netrw act like a project Draw

"augroup ProjectDrawer
"    autocmd!
"    " Don't open Netrw
"    autocmd VimEnter *.md,*.txt,*.h,*.conf,*.sh,*.vim,\.* let b:noNetrw=1
"    autocmd VimEnter * :call NetrwOnBufferOpen()
"augroup END

let g:NetrwIsOpen=0
]])

--tabs manipulation
vim.cmd([[
nn <M-1> 1gt
nn <M-2> 2gt
nn <M-3> 3gt
nn <M-4> 4gt
nn <M-5> 5gt
nn <M-6> 6gt
nn <M-7> 7gt
nn <M-8> 8gt
nn <M-9> 9gt
nn <M-0> :tablast<CR>
]])
-- C++ Header Files
vim.cmd([[

#!vim
function! CPPTitleInsert()
call setline(1,'#include <iostream>')
call append(1,'#include <cstdio>')
call append(2,'#include <cstdlib>')
call append(3,'#include <queue>')
call append(4,'#include <stack>')
call append(5,'#include <algorithm>')
call append(6,'#include <string>')
call append(7,'#include <map>')
call append(8,'#include <set>')
call append(9,'#include <vector>')
call append(10,'#include <cstring>')
call append(11,'using namespace std;')
call append(12,'')
call append(13,"//Date: " . strftime("%Y-%m-%d %H:%M:%S")  )
call append(14,'')
call append(15,"//Last modified: " . strftime("%Y-%m-%d %H:%M:%S")  )
call append(16,'')
endfunction
function! DateInsert()
call cursor(7,1)
if search('Last modified') != 0
    let line = line('.')
    call setline(line,"Last modified: " . strftime("%Y-%m-%d %H:%M:%S"))
endif
endfunction

:map <F3> :call CPPTitleInsert()<CR>ggjjA
:autocmd FileWritePre,BufWritePre *.cpp ks|call DateInsert()|'s
]])

-- MarkDown Header
vim.cmd([[

#!vim
function! MDTitleInsert()
call setline(1,'<meta name="viewport" content="width=device-width, initial-scale=1">')
call append(1,'<link rel="stylesheet" href="github-markdown.css">')
call append(2,'<style>')
call append(3,'	.markdown-body {')
call append(4,'		box-sizing: border-box;')
call append(5,'		min-width: 200px;')
call append(6,'		max-width: 980px;')
call append(7,'		margin: 0 auto;')
call append(8,'		padding: 45px;')
call append(9,'	}')
call append(10,'')
call append(11,'	@media (max-width: 767px) {')
call append(12,'		.markdown-body {')
call append(13,'			padding: 15px;')
call append(14,'		}')
call append(15,'	}')
call append(16,'</style>')
call append(17,'<article class="markdown-body">')
call append(18,'	<h1>Unicorns</h1>')
call append(19,'	<p>All the things</p>')
call append(20,'</article>')
call append(21,'')
call append(22,"Date: " . strftime("%Y-%m-%d %H:%M:%S")  )
call append(23,'')
call append(24,"Last modified: " . strftime("%Y-%m-%d %H:%M:%S")  )
call append(25,'')
endfunction
function! DateInsert()
call cursor(7,1)
if search('Last modified') != 0
    let line = line('.')
    call setline(line,"Last modified: " . strftime("%Y-%m-%d %H:%M:%S"))
endif
endfunction

:map <F4> :call MDTitleInsert()<CR>ggjjA
:autocmd FileWritePre,BufWritePre *.md ks|call DateInsert()|'s
]])
