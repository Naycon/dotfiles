call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

"Plug 'vim-airline/vim-airline'
"Plug 'itchyny/lightline.vim'
Plug 'hoob3rt/lualine.nvim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'tpope/vim-surround'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-angular'

Plug 'tomtom/tcomment_vim'

Plug 'phaazon/hop.nvim'

Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-fuzzy.vim'
Plug 'haya14busa/incsearch-easymotion.vim'

Plug 'mhartington/formatter.nvim'
" Plug 'mfussenegger/nvim-lint'

Plug 't9md/vim-choosewin'

Plug 'neovim/nvim-lspconfig'

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}

" Color themes
Plug 'morhetz/gruvbox'
Plug 'flrnd/candid.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'projekt0n/github-nvim-theme'

" Initialize plugin system
call plug#end()
" ===================================


" ENABLE TRUECOLORS
" ===================================
set termguicolors
" ===================================


" SET COLOR SCHEME/THEME
" ===================================

" --- gruvbox ---
" let g:gruvbox_contrast_dark="hard"
" colorscheme gruvbox

" --- candid ---
" set background=dark
" syntax on
" let g:candid_color_store = {
"     \ "black": {"gui": "#151515", "cterm256": "0"},
"     \ "white": {"gui": "#f4f4f4", "cterm256": "255"},
"     \}
" colorscheme candid
"
" --- ayu ---
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
"
" --- github theme ---
let g:github_dark_sidebar = 0
colorscheme github_dark_default
" ===================================


" REMAP LEADER
" ===================================
:let mapleader = "\<space>"
" ===================================


" SHOW LINE NUMBERS
" ===================================
set number
" ===================================


" SPLIT BEHAVIOUR
" ===================================
set splitbelow
set splitright
" ===================================


" SET TABS TO 2 SPACES
" ===================================
filetype plugin indent on
" On pressing tab, insert 2 spaces
set expandtab
" show existing tab with 2 spaces width
set tabstop=2
set softtabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" ===================================


" HIGHLIGHT ON YANK
" ===================================
augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank { higroup='IncSearch', timeout=200 }
augroup END
" ===================================


" TRIM WHITESPACE ON SAVE
" ===================================
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


" SET HIDDEN
" ===================================
" Needed to be able to change buffer without saving first.
set hidden
" ===================================


" ENABLE WILDMENU <TAB> COMPLETION
" ===================================
set wildmenu
set wildmode=longest:full,full
" ===================================


" SPEED IMPROVEMENTS
" ===================================
set lazyredraw
" ===================================


" KEYBINDINGS
" ===================================
:nnoremap <silent> <C-p> <cmd>Telescope find_files<cr>
" esc leaves insert mode in terminal
:tnoremap <Esc> <C-\><C-n>
" gh switches between the last two buffers
:nnoremap gh :b#<CR>
" gb to switch between open buffers
:nnoremap gb <cmd>Telescope buffers<CR>
" ctrl + g to search all files with Telescope
:nnoremap <C-g> :Telescope grep_string search=
" ctrl + f to live search all files with Telescope
:nnoremap <C-f> :Telescope live_grep<CR>
" space + g to search word under cursor in all files with Telescope
:nnoremap <Leader>g <cmd>Telescope grep_string<cr>
:xnoremap <Leader>g y:Telescope grep_string search=<c-r>"<CR>
" arrow keys to move between splits
:nnoremap <Left> <c-w>h
:nnoremap <Down> <c-w>j
:nnoremap <Up> <c-w>k
:nnoremap <Right> <c-w>l
" ===================================


" NVIM-TREE CONFIG
" ===================================
" let g:nvim_tree_width = 50
:nnoremap <silent> <C-h> :NvimTreeToggle<CR>
:nnoremap <silent> <C-j> :NvimTreeFindFile<CR>
lua << EOF
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  view = {
    width = 50,
    mappings = {
      list = {
        { key = "m", cb = tree_cb("rename") },
        { key = "r", cb = tree_cb("refresh") }
      }
    }
  },
}
EOF
" ===================================


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


" GITSIGNS CONFIG
" ===================================
lua << EOF
require('gitsigns').setup()
EOF
" ===================================


" LUALINE CONFIG
" ===================================
lua << EOF
require('lualine').setup {
  options = {
    theme = 'github',
    extensions = { 'nvim-tree', 'fzf' },
    component_separators = { '|', '|' },
  },
  sections = {
    lualine_c = {
      {
        'filename',
        file_status = false, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
      {
        'bo:modified',
        format = function(modified)
          if modified == "false" then
            return ""
          else
            return "[modified]"
          end
        end
      }
    },
    lualine_x = {
      {
        'diagnostics',
        -- table of diagnostic sources, available sources:
        -- nvim_lsp, coc, ale, vim_lsp
        sources = { 'nvim_lsp' },
        -- displays diagnostics from defined severity
        sections = {'error', 'warn', 'info', 'hint'},
        -- all colors are in format #rrggbb
        color_error = nil, -- changes diagnostic's error foreground color
        color_warn = nil, -- changes diagnostic's warn foreground color
        color_info = nil, -- Changes diagnostic's info foreground color
        color_hint = nil, -- Changes diagnostic's hint foreground color
        symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'}
      }
    },
    lualine_y = {
      {
          'diff'
      }
    }
  }
}
EOF
" ===================================


" FZF CONFIG
" ===================================
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
" ===================================


" COQ CONFIG
" ===================================
let g:coq_settings = {
      \ 'auto_start': v:true,
      \ 'keymap.jump_to_mark': '<C-n>',
      \ }
" " Make sure <Esc> closes completion window but does not leave insert mode
inoremap <silent><expr><Esc> pumvisible() ? "<C-e>" : "\<Esc>"

" autocmd VimEnter * COQnow [--shut-up]
" lua << EOF
" local coq = require "coq"
"
" vim.cmd([[COQnow]])
" EOF
" ===================================


" LSP CONFIG
" ===================================
lua << EOF
local nvim_lsp = require "lspconfig"
local coq = require "coq"

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
  init_options = {
    hostInfo = "neovim",
    preferences = {
      quotePreference = "single",
      importModuleSpecifierPreference = "relative",
      allowTextChangesInNewFiles = true,
      allowRenamteOfImportPath = true
    }
  },
})
nvim_lsp.angularls.setup{}
nvim_lsp.cssls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))
nvim_lsp.html.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))
nvim_lsp.jsonls.setup(coq.lsp_ensure_capabilities({
  on_attach = on_attach,
}))
nvim_lsp.eslint.setup{}
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = { 'tsserver' }
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup({
--     on_attach = on_attach,
--     flags = {
--       debounce_text_changes = 150,
--     }
--   })
-- end
EOF
" " ===================================


" CHOOSEWIN CONFIG
" ===================================
nmap <End> <Plug>(choosewin)
" ===================================


" HOP CONFIG
" ===================================

lua << EOF
-- require'hop'.setup { keys = 'FKLAHSDGWERUIOGTYPQNVBMCXJ' }
require'hop'.setup()
EOF

" map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j :HopLineAC<CR>
map <Leader>k :HopLineBC<CR>
" map <Leader>l <Plug>(easymotion-lineforward)
map  <Leader>w :HopWord<CR>
nmap <Leader>w :HopWord<CR>
map s :HopChar2<CR>
" ===================================


" FORMATTER CONFIG
" ===================================
" Prettierd
lua << EOF

require('formatter').setup({
  logging = false,
  filetype = {
    typescript = {
        -- prettierd
       function()
          return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
  }
})

vim.api.nvim_exec([[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.ts,*.js FormatWrite
  augroup END
]], true)
EOF
" ===================================

