call plug#begin('~/.local/share/nvim/plugged')

" Make sure you use single quotes

"Plug 'vim-airline/vim-airline'
"Plug 'itchyny/lightline.vim'
Plug 'hoob3rt/lualine.nvim'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-ui-select.nvim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'nvim-treesitter/nvim-treesitter-angular'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'simrat39/symbols-outline.nvim'

Plug 'tomtom/tcomment_vim'

Plug 'phaazon/hop.nvim'

Plug 'kylechui/nvim-surround'

Plug 'haya14busa/incsearch.vim'

Plug 'mhartington/formatter.nvim'

Plug 't9md/vim-choosewin'

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/nvim-cmp'
Plug 'dcampos/nvim-snippy'
Plug 'dcampos/cmp-snippy'

Plug 'MunifTanjim/nui.nvim'

" Color themes
"Plug 'morhetz/gruvbox'
"Plug 'flrnd/candid.vim'
"Plug 'ayu-theme/ayu-vim'
"Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'projekt0n/github-nvim-theme'

Plug 'rktjmp/lush.nvim'
Plug 'uloco/bluloco.nvim'

" Plug 'github/copilot.vim'

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
" let g:github_dark_sidebar = 0
" colorscheme github_dark_default
"
" --- github theme ---
lua << EOF
require("bluloco").setup({
  style = "light",               -- "auto" | "dark" | "light"
  transparent = false,
  italics = false,
  terminal = vim.fn.has("gui_running") == 1, -- bluoco colors are enabled in gui terminals per default.
  guicursor   = true,
})

vim.cmd('colorscheme bluloco')
EOF
" ===================================


" REMAP LEADER
" ===================================
:let mapleader = "\<space>"
" ===================================


" SHOW LINE NUMBERS
" ===================================
" set number
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
" arrow keys to move between splits
:nnoremap <Left> <c-w>h
:nnoremap <Down> <c-w>j
:nnoremap <Up> <c-w>k
:nnoremap <Right> <c-w>l
" ===================================


" TELESCOPE
" ===================================
lua << EOF
local center_dropdown = {
  path_display = { "smart" },
  theme = "dropdown",
  layout_config = {
    center = {
      width = 120,
    },
  },
}
local cursor = {
  layout_strategy = "cursor",
  sorting_strategy = "ascending",
  layout_config = {
    cursor = {
      width = 60,
      height = 8,
    }
  }
}
require('telescope').setup({
  defaults = {
    path_display = function(opts, path)
      local tail = require("telescope.utils").path_tail(path)
      local smartPath = require("telescope.utils").path_smart(path)
      return string.format("%s (%s)", tail, smartPath)
    end,
  },
  pickers = {
    lsp_references = center_dropdown,
    lsp_definitions = vim.tbl_extend("error", center_dropdown, {
      jump_type = "never",
    }),
    lsp_document_diagnostics = center_dropdown,
    lsp_document_symbols = center_dropdown,
    lsp_dynamic_workspace_symbols = center_dropdown,
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_cursor {
        -- even more opts
      }

      -- pseudo code / specification for writing custom displays, like the one
      -- for "codeactions"
      -- specific_opts = {
      --   [kind] = {
      --     make_indexed = function(items) -> indexed_items, width,
      --     make_displayer = function(widths) -> displayer
      --     make_display = function(displayer) -> function(e)
      --     make_ordinal = function(e) -> string
      --   },
      --   -- for example to disable the custom builtin "codeactions" display
      --      do the following
      --   codeactions = false,
      -- }
    }
  }
})
require("telescope").load_extension("ui-select")
EOF
" gb to switch between open buffers
:nnoremap gb <cmd>Telescope buffers<CR>
" gc to see command history
:nnoremap gc <cmd>Telescope command_history<CR>
" ctrl + g to search all files with Telescope
:nnoremap <C-g> :Telescope grep_string search=
" ctrl + f to live search all files with Telescope
:nnoremap <C-f> :Telescope current_buffer_fuzzy_find<CR>
:nnoremap <C-a> :Telescope live_grep<CR>
" space + g to search word under cursor in all files with Telescope
:nnoremap <Leader>g <cmd>Telescope grep_string<cr>
:xnoremap <Leader>g y:Telescope grep_string search=<c-r>"<CR>
"
" " Preview definition
:nnoremap <silent> gd <cmd>Telescope lsp_definitions<CR>
" " Preview references
:nnoremap <silent> gr <cmd>Telescope lsp_references<CR>
" " Code actions under cursor
" :nnoremap <silent><leader>ca <cmd>Telescope lsp_code_actions<CR>
" :vnoremap <silent><leader>ca :<C-U>Telescope lsp_range_code_actions<CR>
" " Show diagnostics
:nnoremap <silent><leader>cd <cmd>Telescope lsp_document_diagnostics<CR>
" " Document symbols
:nnoremap <silent>gs <cmd>Telescope lsp_document_symbols<CR>
" " Workspace symbols
:nnoremap <silent>gws <cmd>Telescope lsp_dynamic_workspace_symbols<CR>
" nnoremap <silent> gp <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
" " Code actions
" nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
" vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
" " Hover doc
" nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
" " Signature help
" nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
" " Rename
" nnoremap <silent><leader>rn <cmd>lua require('lspsaga.rename').rename()<CR>
" " Show diagnostics
" nnoremap <silent><leader>cd <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>
" " Jump to diagnostics
" nnoremap <silent><leader>cn <cmd>lua require'lspsaga.diagnostic'.navigate("next")()<CR>
" nnoremap <silent><leader>cp <cmd>lua require'lspsaga.diagnostic'.navigate("prev")()<CR>
" " Show terminal
" nnoremap <silent> gt <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
" " Scroll down hover doc or scroll in definition preview
" nnoremap <silent><leader>d <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
" " Scroll up hover doc
" nnoremap <silent><leader>u <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
"
" ===================================


" NVIM-TREE CONFIG
" ===================================
" let g:nvim_tree_width = 50
:nnoremap <silent> <C-h> :NvimTreeToggle<CR>
:nnoremap <silent> <C-j> :NvimTreeFindFile<CR>
lua << EOF

local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings. Feel free to modify or remove as you wish.
  --
  -- BEGIN_DEFAULT_ON_ATTACH
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
  vim.keymap.set('n', '<C-k>', api.node.show_info_popup,              opts('Info'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub,                     opts('Rename: Omit Filename'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab,                     opts('Open: New Tab'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical,                opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal,              opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<BS>',  api.node.navigate.parent_close,        opts('Close Directory'))
  vim.keymap.set('n', '<CR>',  api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview,                 opts('Open Preview'))
  vim.keymap.set('n', '>',     api.node.navigate.sibling.next,        opts('Next Sibling'))
  vim.keymap.set('n', '<',     api.node.navigate.sibling.prev,        opts('Previous Sibling'))
  vim.keymap.set('n', '.',     api.node.run.cmd,                      opts('Run Command'))
  vim.keymap.set('n', '-',     api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', 'a',     api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'bmv',   api.marks.bulk.move,                   opts('Move Bookmarked'))
  vim.keymap.set('n', 'B',     api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer'))
  vim.keymap.set('n', 'c',     api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', 'C',     api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean'))
  vim.keymap.set('n', '[c',    api.node.navigate.git.prev,            opts('Prev Git'))
  vim.keymap.set('n', ']c',    api.node.navigate.git.next,            opts('Next Git'))
  vim.keymap.set('n', 'd',     api.fs.remove,                         opts('Delete'))
  vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'E',     api.tree.expand_all,                   opts('Expand All'))
  vim.keymap.set('n', 'e',     api.fs.rename_basename,                opts('Rename: Basename'))
  vim.keymap.set('n', ']e',    api.node.navigate.diagnostics.next,    opts('Next Diagnostic'))
  vim.keymap.set('n', '[e',    api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic'))
  vim.keymap.set('n', 'F',     api.live_filter.clear,                 opts('Clean Filter'))
  vim.keymap.set('n', 'f',     api.live_filter.start,                 opts('Filter'))
  vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', 'gy',    api.fs.copy.absolute_path,             opts('Copy Absolute Path'))
  vim.keymap.set('n', 'H',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'I',     api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'J',     api.node.navigate.sibling.last,        opts('Last Sibling'))
  vim.keymap.set('n', 'K',     api.node.navigate.sibling.first,       opts('First Sibling'))
  vim.keymap.set('n', 'm',     api.marks.toggle,                      opts('Toggle Bookmark'))
  vim.keymap.set('n', 'o',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'O',     api.node.open.no_window_picker,        opts('Open: No Window Picker'))
  vim.keymap.set('n', 'p',     api.fs.paste,                          opts('Paste'))
  vim.keymap.set('n', 'P',     api.node.navigate.parent,              opts('Parent Directory'))
  vim.keymap.set('n', 'q',     api.tree.close,                        opts('Close'))
  vim.keymap.set('n', 'r',     api.fs.rename,                         opts('Rename'))
  vim.keymap.set('n', 'R',     api.tree.reload,                       opts('Refresh'))
  vim.keymap.set('n', 's',     api.node.run.system,                   opts('Run System'))
  vim.keymap.set('n', 'S',     api.tree.search_node,                  opts('Search'))
  vim.keymap.set('n', 'U',     api.tree.toggle_custom_filter,         opts('Toggle Hidden'))
  vim.keymap.set('n', 'W',     api.tree.collapse_all,                 opts('Collapse'))
  vim.keymap.set('n', 'x',     api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', 'y',     api.fs.copy.filename,                  opts('Copy Name'))
  vim.keymap.set('n', 'Y',     api.fs.copy.relative_path,             opts('Copy Relative Path'))
  vim.keymap.set('n', '<2-LeftMouse>',  api.node.open.edit,           opts('Open'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  -- END_DEFAULT_ON_ATTACH

  -- Keymap overrides
  vim.keymap.set('n', 'm', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'r', api.tree.reload, opts('Refresh'))
end
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  view = {
    width = 50,
  },
  on_attach = on_attach,
}
EOF
" ===================================


" TREESITTER CONFIG
" ===================================
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "css", "dart", "dockerfile", "html", "java", "javascript", "jsdoc", "json", "python", "scss", "tsx", "typescript", "vim", "yaml" }, -- "all" or a list of languages
  ignore_install = { "vala", "latex" }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "c", "rust", "vala", "latex" },  -- list of language that will be disabled
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
    theme = 'auto',
    extensions = { 'nvim-tree', 'fzf' },
    component_separators = { '|', '|' },
  },
  sections = {
    lualine_b = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_c = {},
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
  },
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


" NVIM CMP CONFIG
" ===================================
lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require('snippy').expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    experimental = {
      ghost_text = true -- NOTE: this feature conflicts with copilot.vim's preview. Turn off if using that plugin!
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
EOF
" ===================================


" NAVIGATOR CONFIG
" ===================================
" lua <<EOF
" require'navigator'.setup({
"   transparency = 100,
"   lsp = {
"     disable_lsp = {"denols"},
"     tsserver = {
"       init_options = {
"         hostInfo = "neovim",
"         preferences = {
"           quotePreference = "single",
"           importModuleSpecifierPreference = "relative",
"           allowTextChangesInNewFiles = true,
"           allowRenameOfImportPath = true
"         }
"       },
"     },
"     servers = {'eslint'}
"   },
" })
" EOF
" ===================================


" LSP CONFIG
" ===================================
lua << EOF

local nvim_lsp = require "lspconfig"
-- local coq = require "coq"
local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions

  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<Leader>cs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Leader>h', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)

  -- buf_set_keymap('n', '<Leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- buf_set_keymap('n', '<Leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  -- buf_set_keymap('n', '<Leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- nvim_lsp.tsserver.setup(coq.lsp_ensure_capabilities({
nvim_lsp.tsserver.setup {
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
      allowRenameOfImportPath = true
    }
  },
  capabilities = capabilities
}
-- nvim_lsp.angularls.setup{}
-- nvim_lsp.cssls.setup(coq.lsp_ensure_capabilities({
nvim_lsp.cssls.setup {
  capabilities = capabilities
  -- on_attach = on_attach,
}
-- nvim_lsp.html.setup(coq.lsp_ensure_capabilities({
nvim_lsp.html.setup {
  capabilities = capabilities
  -- on_attach = on_attach,
}
-- nvim_lsp.jsonls.setup(coq.lsp_ensure_capabilities({
nvim_lsp.jsonls.setup {
  capabilities = capabilities
  -- on_attach = on_attach,
}
nvim_lsp.eslint.setup{}
EOF
" ===================================


" CHOOSEWIN CONFIG
" ===================================
nmap <End> <Plug>(choosewin)
" ===================================


" NVIM SURROUND CONFIG
" ===================================
lua << EOF
require("nvim-surround").setup()
EOF
" ===================================


" HOP CONFIG
" ===================================
lua << EOF
-- require'hop'.setup { keys = 'FKLAHSDGWERUIOGTYPQNVBMCXJ' }
require'hop'.setup()
EOF

" map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <cmd>HopLineAC<CR>
map <Leader>k <cmd>HopLineBC<CR>
" map <Leader>l <Plug>(easymotion-lineforward)
map  <Leader>w <cmd>HopWord<CR>
" nmap <Leader>w <cmd>HopWord<CR>
map s <cmd>HopChar2<CR>
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
    typescriptreact = {
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
    autocmd BufWritePost *.ts,*.tsx,*.js FormatWrite
  augroup END
]], true)
EOF
" ===================================


" SYMBOLS-OUTLINE
" ===================================
lua << EOF
require("symbols-outline").setup()
EOF

:nnoremap <silent><leader>o <cmd>SymbolsOutline<CR>
" ===================================
