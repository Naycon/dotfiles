call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

"Plug 'vim-airline/vim-airline'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-angular'
Plug 'tomtom/tcomment_vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript'] }

" Color themes
Plug 'morhetz/gruvbox'
Plug 'flrnd/candid.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }

" Initialize plugin system
call plug#end()
" ===================================


" ENABLE TRUECOLORS
set termguicolors
" ===================================


" SET COLOR SCHEME/THEME

" --- gruvbox ---
" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox

" --- candid ---
" set background=dark
" syntax on
let g:candid_color_store = {
    \ "black": {"gui": "#151515", "cterm256": "0"},
    \ "white": {"gui": "#f4f4f4", "cterm256": "255"},
    \}
" colorscheme candid
"
" --- ayu ---
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
let ayucolor="dark"   " for dark version of theme
colorscheme ayu

" ===================================


" REMAP LEADER
:let mapleader = "\<space>"
" ===================================


" SHOW LINE NUMBERS
set number
" ===================================


" SPLIT BEHAVIOUR
set splitbelow
set splitright
" ===================================



" SET TABS TO 2 SPACES
filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" ===================================


" TRIM WHITESPACE ON SAVE
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
" Change * below if stripping is not desired on all file endings. E.g. set it
" to *.js to only strip whitespace on js files.
autocmd BufWritePre * :%s/\s\+$//e
" ===================================


" ENABLE WILDMENU <TAB> COMPLETION
set wildmenu
set wildmode=longest:full,full
" ===================================


" SPEED IMPROVEMENTS
set lazyredraw
" ===================================


" KEYBINDINGS
:nnoremap <silent> <C-p> :Files<CR>
:nnoremap <silent> <C-h> :NERDTreeToggle<CR>
" esc leaves insert mode in terminal
:tnoremap <Esc> <C-\><C-n>
" gh switches between the last two buffers
:nnoremap gh :b#<CR>
" ctrl + f to search all files
:nnoremap <C-f> :BLines<CR>
:nnoremap <C-g> :Rg<space>
:nnoremap <Leader>g :Rg<space><c-r><c-w><CR>


" TREESITTER CONFIG
" ===================================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust" },  -- list of language that will be disabled
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF
" ===================================

" LIGHTLINE CONFIG
set noshowmode
" Always show tabline
set showtabline=2

function! GetShortFilename()
  let f = fnamemodify(expand("%"), ":~:.")
  return pathshorten(f)
endfunction
function! GetTabShortFilename(n)
  return GetShortFilename()
endfunction
function! GetFullFilename()
  return fnamemodify(expand("%"), ":~:.")
endfunction
function! GetTabFullFilename(n)
  return GetFullFilename()
endfunction

let g:lightline = {
      \ 'colorscheme': 'candid',
      \ 'enable': {
      \   'statusline': 1,
      \   'tabline': 1,
      \ },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'filetype' ] ]
      \ },
      \ 'inactive': {
      \   'left': [ [ 'filename' ] ],
      \   'right': [ [ 'lineinfo' ], [ 'percent' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ [ 'tabs' ] ],
      \   'right': []
      \ },
      \ 'tab': {
      \   'active': [ 'tabnum', 'readonly', 'fullfilename', 'modified' ],
      \   'inactive': [ 'tabnum', 'readonly', 'filename', 'modified' ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead',
      \   'filename': 'GetShortFilename',
      \   'fullfilename': 'GetFullFilename',
      \ },
      \ 'component': {
      \   'lineinfo': '%3l:%-2c%<',
      \ },
      \ 'tab_component_function': {
      \   'filename': 'GetTabShortFilename',
      \   'fullfilename': 'GetTabFullFilename',
      \ },
    \ }
" ===================================

" AIRLINE CONFIG
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" ===================================


" BETTER RAINBOW PARENTHESIS
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" ===================================


" FZF CONFIG
" Reverse the layout to make the FZF list top-down
let $FZF_DEFAULT_OPTS='--layout=default --border --margin=0,2'

" Using the custom window creation function
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)

  " 70% of the height
  let height = float2nr(&lines * 0.7)
  " 70% of the height
  let width = float2nr(&columns * 0.7)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (centralized)
  let vertical = float2nr((&lines - height) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

:nnoremap <silent> gb :Buffers<CR>
" ===================================


" COC CONFIG
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make sure <Esc> closes completion window but does not leave insert mode
" inoremap <expr><Esc> pumvisible() ? "<C-e>" : "\<Esc>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> gs  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> ga  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" COC YANK command
nnoremap <silent> <Leader>p  :<C-u>CocList -A --normal yank<cr>
" ===================================

" EASYMOTION CONFIG
let g:EasyMotion_keys = 'FKLAHSDGWERUIOGTYPQNVBMCXJÖ'

" use upper case to display easymotion target labels (still allows use of
" lower case keys)
let g:EasyMotion_use_upper = 1

" hjkl motions
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-lineforward)

" keep cursor column when JK motion
let g:EasyMotion_startofline = 0

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" Two character search motion
map s <Plug>(easymotion-s2)
nmap s <Plug>(easymotion-overwin-f2)
nmap t <Plug>(easymotion-t2)
" ===================================


" INCSEARCH EASYMOTION CONFIG
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction

noremap <silent><expr> <Leader>s incsearch#go(<SID>config_easyfuzzymotion())
noremap <silent><expr> <Leader>/ incsearch#go(<SID>config_easyfuzzymotion())
" ===================================


" COC PRETTIER
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat_config_present = 1
" when running at every change you may want to disable quickfix
" let g:prettier#quickfix_enabled = 0
let g:prettier#config#tab_width = '2'

" autocmd TextChanged,InsertLeave *.ts,*.tsx PrettierAsync
autocmd BufWritePre *.ts Prettier
" ===================================
