local opts = { noremap = true, silent = true }
--local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --

-- Pairs
keymap("i","{","{}<ESC>i",opts)
keymap("i","[","[]<LEFT>",opts)
keymap("i","(","()<LEFT>",opts)
keymap("i","<c-d>","<DELETE>",opts)
keymap("i","]","<c-r>=SkipSquarebrackets()<CR>",opts)
keymap("i",")","<c-r>=SkipParentheses()<CR>",opts)
keymap("i","}","<c-r>=SkipCurlybrackets()<CR>",opts)

vim.cmd([[
func SkipParentheses()
    if getline('.')[col('.') - 1] == ')'
        return "\<ESC>la"
    else
        return ")"
    endif
endfunc

func SkipCurlybrackets()
    if getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "}"
    endif
endfunc

func SkipSquarebrackets()
    if getline('.')[col('.') - 1] == ']'
        return "\<ESC>la"
    else
        return "]"
    endif
endfunc
]])
-- Netrw
keymap("n","<leader>e",":call ToggleNetrw()<CR>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n","<C-l>","<C-w>l", opts)
-- Fix <C-l> acting weird from netrw to window
vim.cmd([[
augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
  nnoremap <buffer> <c-l> :wincmd l<cr>
endfunction
]])
-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Naviagate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap("n", "[e", ":<c-u>execute 'move -1-'. v:count1<cr>", opts)
keymap("n", "]e", ":<c-u>execute 'move +'. v:count1<cr>", opts)

-- Insert --
-- Press jk fast to enter
-- keymap("i", "lh", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
keymap("n", "<leader>t", ":bo 12new<CR>:terminal<CR>", opts)

-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

--MarkdownPreview
keymap("n", "<leader>mp",":MarkdownPreview<CR>",opts)
keymap("n", "<leader>ms",":MarkdownPreviewStop<CR>",opts)
-- Custom
keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)


--保 存
keymap('n', '<C-s>', ':w<CR>', opts)
-- 命令行历史
keymap('c', '<c-n>','<down>', opts)
keymap('c', '<c-p>','<up>', opts)

--copy & paste
keymap('n', '<leader>y', '\"+y', opts)
keymap('v', '<leader>y', '\"+y', opts)
keymap('n', '<leader>Y', '\"+Y', opts)

--excutable
keymap('n', '<leader>x', '<cmd>!chmod +x %<CR>', opts)
------按键映射 end  ------
