vim9script
set number
set showmatch
set hlsearch
set smartcase
set ignorecase
set incsearch
set autoindent
set expandtab
set shiftwidth=4
set smarttab	 
set softtabstop=4	
set ruler	
set undoreload=20000
set undolevels=2000	
set backspace=indent,eol,start
filetype plugin indent on
syntax on
syntax sync minlines=200 maxlines=500
set swapfile
set directory=$HOME/.vim/swap//
set backup
set backupdir=$HOME/.vim/backup//
set undofile
set undodir=$HOME/.vim/undo//
set noshowmode
set laststatus=2
set statusline=%{mode()=='n'?'NORMAL':mode()=='i'?'INSERT':mode()=='v'?'VISUAL':mode()=='V'?'V\ \ \ \ \ -LINE':mode()=='␖'?'V-BLOCK':mode()=='R'?'REPLACE':mode()=='c'?'COMMAND':mode()}\ %{&modified?'+':&modifiable?'':'-'}\ %f\ [%{(&ft!=''?&ft[0]->toupper().&ft[1:]:'none')}]%=\ %l:%c\ (%p%%)
set termguicolors
set updatetime=500
set signcolumn=yes
set cursorline
set foldmethod=indent

# AUTO-SAVE
augroup AutoSaveGroup
    autocmd!
    autocmd BufLeave,FocusLost,InsertLeave * if &modified && !empty(expand('%')) && &buftype == '' | silent update | endif
augroup END

# AUTO-CLOSE BRACKETS, QUOTES, PARENTESIS
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap ` ``<Left>
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>

# PACKADD
packadd! comment

# THEME
set background=dark
g:gruvbox_contrast_dark = 'soft'
g:gruvbox_bold = 1
g:gruvbox_italic = 1
colorscheme gruvbox
highlight SignColumn ctermbg=NONE guibg=NONE
highlight CursorLine ctermbg=NONE guibg=NONE ctermfg=NONE guifg=NONE

# THEME LSP
highlight LspDiagInlineError ctermbg=RED ctermfg=WHITE guibg=RED guifg=WHITE
highlight LspDiagInlineHint ctermbg=CYAN ctermfg=BLACK guibg=CYAN guifg=BLACK
highlight LspDiagInlineInfo ctermbg=DARKMAGENTA ctermfg=WHITE guibg=DARKMAGENTA guifg=WHITE
highlight LspDiagInlineWarning ctermbg=YELLOW ctermfg=BLACK guibg=YELLOW guifg=BLACK

highlight LspDiagSignErrorText ctermbg=NONE ctermfg=RED guibg=NONE guifg=RED
highlight LspDiagSignHintText ctermbg=NONE ctermfg=CYAN guibg=NONE guifg=CYAN
highlight LspDiagSignInfoText ctermbg=NONE ctermfg=DARKMAGENTA guibg=NONE guifg=DARKMAGENTA
highlight LspDiagSignWarningText ctermbg=NONE ctermfg=YELLOW guibg=NONE guifg=YELLOW

highlight LspDiagVirtualTextError ctermbg=RED ctermfg=WHITE guibg=RED guifg=WHITE
highlight LspDiagVirtualTextHint ctermbg=CYAN ctermfg=BLACK guibg=CYAN guifg=BLACK
highlight LspDiagVirtualTextInfo ctermbg=DARKMAGENTA ctermfg=WHITE guibg=DARKMAGENTA guifg=WHITE
highlight LspDiagVirtualTextWarning ctermbg=YELLOW ctermfg=BLACK guibg=YELLOW guifg=BLACK

# FUZZBOX KEYMAP
nnoremap <silent> <leader>fb :FuzzyBuffers<CR>
nnoremap <silent> <leader>ff :FuzzyFiles<CR>
nnoremap <silent> <leader>fg :FuzzyGrep<CR>
nnoremap <silent> <leader>fh :FuzzyHelp<CR>
nnoremap <silent> <leader>fi :FuzzyInBuffer<CR>
nnoremap <silent> <leader>fr :FuzzyMru<CR>
nnoremap <silent> <leader>fp :FuzzyPrevious<CR>
nnoremap <silent> <leader>fq :FuzzyQuickfix<CR>

# SNIPPETS KEYMAP
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
g:user_emmet_leader_key = '<c-e>'

# LSP KEYMAP
nnoremap <silent> gd :LspGotoDefinition<cr>
nnoremap <silent> K  :LspHover<cr>
nnoremap <silent> [d :LspDiag prev<cr>
nnoremap <silent> ]d :LspDiag next<cr>
nnoremap <silent> <leader>rn :LspRename<cr>
nnoremap <silent> <leader>ca :LspCodeAction<cr>
nnoremap <silent> <leader>fe :LspFormat<cr>

# LSP CONFIGURATION
var lspOpts = {
    autoComplete: true,
    autoHighlightDiags: true,
    diagSignErrorText: '■',
    diagSignHintText: '◆',
    diagSignInfoText: '●',
    diagSignWarningText: '▲',
    highlightDiagInline: true,
    ignoreMissingServer: false,
    completionTextEdit: true,
    diagVirtualTextAlign: 'above',
    maxDiagnostics: 200,
    semanticHighlight: true,
    showDiagWithSign: true,
    showDiagWithVirtualText: true,
    showSignature: true,
    snippetSupport: true,
    vsnipSupport: true,
    bufferCompletionTimeout: 500,
}

# LSP SERVERS
var lspServers = [
    {
        name: 'clangd',
        filetype: ['c', 'cpp'],
        path: 'clangd',
        args: ['--background-index']
    },
    {
        name: 'rust-analyzer',
        filetype: ['rust'],
        path: 'rust-analyzer',
        args: [],
        syncInit: true
    },
    {
        name: 'basedpyright',
        filetype: ['python'],
        path: 'basedpyright-langserver',
        args: ['--stdio'],
        rootSearch: ['pyproject.toml']
    },
    {
        name: 'ruff',
        filetype: ['python'],
        path: 'ruff',
        args: ['server'],
        rootSearch: ['pyproject.toml'],
        initializationOptions: {
            settings: {
                lint: { enable: true }
            }
        }
    },
    {
        name: 'deno',
        filetype: ['javascript', 'typescript', 'javascriptreact', 'typescriptreact'],
        path: 'deno',
        args: ['lsp'],
        rootSearch: ['deno.json'],
        initializationOptions: {
            enable: true,
            lint: false, 
            suggest: {
                imports: {
                    hosts: {
                        'https://deno.land': true,
                        'https://jsr.io': true
                    }
                }
            }
        }
    },
    {
        name: 'oxlint',
        filetype: ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
        path: 'oxlint',
        args: ['--lsp'],
        rootSearch: ['.oxlintrc.json']
    },
    {
        name: 'vscode-html-server',
        filetype: ['html'],
        path: 'vscode-html-language-server',
        args: ['--stdio']
    },
    {
        name: 'vscode-css-server',
        filetype: ['css', 'scss', 'less', 'sass'],
        path: 'vscode-css-language-server',
        args: ['--stdio']
    },
    {
        name: 'vscode-json-server',
        filetype: ['json', 'jsonc'],
        path: 'vscode-json-language-server',
        args: ['--stdio']
    },
    {
        name: 'yaml-server',
        filetype: ['yaml', 'yml'],
        path: 'yaml-language-server',
        args: ['--stdio']
    },
    {
        name: 'taplo',
        filetype: ['toml'],
        path: 'taplo',
        args: ['lsp', 'stdio']
    }
]
augroup LspSetupGroup
    autocmd!
    autocmd User LspSetup {
        call LspOptionsSet(lspOpts)
        call LspAddServer(lspServers)
    }
augroup END

# OXFMT
def FormatOxfmt()
  var save_cursor = getcurpos()
  var save_view = winsaveview()
  var lines = getline(1, '$')
  var filepath = expand('%:p')
  var cmd = ['oxfmt', '--stdin-filepath=' .. (filepath != '' ? filepath : 'buffer.js')]
  var result = systemlist(cmd, lines)

  if v:shell_error != 0
    echohl ErrorMsg
    echomsg "oxfmt failed: " .. join(result, " ")
    echohl None
    return
  endif

  setline(1, result)
  winrestview(save_view)
  setpos('.', save_cursor)

  echomsg "oxfmt success: File formatted."
enddef

nnoremap <silent> <leader>fo <scriptcmd>FormatOxfmt()<CR>
