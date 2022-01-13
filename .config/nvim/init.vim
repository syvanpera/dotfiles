"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

" Plugins -------------------------------------------------------------------{{{

  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin()

    " Themes
    Plug 'dracula/vim'
    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'joshdick/onedark.vim'
    Plug 'pineapplegiant/spaceduck', { 'branch': 'main' }
    Plug 'NLKNguyen/papercolor-theme'
    " Airline
    Plug 'vim-airline/vim-airline'
    " Make navigation between vim & tmux easier
    Plug 'christoomey/vim-tmux-navigator'
    " A file system tree explorer
    Plug 'preservim/nerdtree'
    " Devicon support for nerdtree
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    " Comment anything
    Plug 'tomtom/tcomment_vim'
    " Efficient syntax highlighting
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " Collection of language packs
    Plug 'sheerun/vim-polyglot'
    " Telescope fuzzy finder over lists
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    " Golang support
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

  call plug#end()

" }}}

" General settings ----------------------------------------------------------{{{

  " language en_US
  let mapleader=' '

  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  if (has("termguicolors"))
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif

  set hidden
  set shell=bash
  set encoding=UTF-8
  " set list listchars=tab:»·,trail:·,nbsp:·
  set scrolloff=0
  " set clipboard+=unnamedplus
  set nocompatible
  set noshowmode
  set noswapfile
  set nobackup
  set nowritebackup
  set number
  set relativenumber
  set numberwidth=4
  set cursorline
  set tabstop=2 shiftwidth=2 expandtab
  set smarttab
  set autoindent
  set shiftround
  set conceallevel=0
  set virtualedit=block
  set wildmenu
  set laststatus=2
  set lazyredraw
  set wrap linebreak
  set wildmode=full
  set autoread
  set complete=.,w,b,u,t,k
  set formatoptions+=t
  set shortmess=atIc
  set isfname-==
  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300
  " Give more space for displaying messages.
  set cmdheight=2
  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c
  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " if has("persistent_undo")
  "   set undodir=~/.vim/undodir
  "   set undofile
  " endif

  "set t_Co=256

  " Clear trailing whitespace when saving buffer
  autocmd BufWritePre * %s/\s\+$//e

  " Turn off relative numbering when going into insert mode
  " autocmd InsertEnter,InsertLeave * set rnu!

  " Remember cursor position between vim sessions
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
        \   exe "normal! g'\"" |
        \ endif
  " center buffer around cursor when opening files
  autocmd BufRead * normal zz

  autocmd InsertEnter,InsertLeave * set cul!

  " Add format option 'w' to add trailing white space, indicating that paragraph
  " continues on next line. This is to be used with mutt's 'text_flowed' option.
  augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
  augroup END " }

" }}}

" Autocommands --------------------------------------------------------------{{{

  " autocmd BufWritePost *sxhkdrc !kill -SIGUSR1 sxhkd

" }}}

" UI ------------------------------------------------------------------------{{{

  set background=dark
  syntax on

  " colorscheme dracula
  " colorscheme spaceduck
  " colorscheme palenight
  colorscheme PaperColor

  " let g:airline_theme = 'spaceduck'
  let g:airline_theme = 'palenight'

  let g:palenight_terminal_italics=1

  highlight Normal guibg=NONE ctermbg=NONE
  " highlight LineNr guibg=NONE ctermbg=NONE
  " highlight EndOfBuffer guibg=NONE ctermbg=NONE
  " highlight SignColumn guibg=NONE ctermbg=NONE

" }}}

" Basic key mappings  -------------------------------------------------------{{{

  nnoremap <leader>v :ed ~/.config/nvim/init.vim<CR>
  nnoremap <leader>u :source ~/.config/nvim/init.vim<CR>

  nnoremap <leader>jf :%!python -m json.tool<CR>

  " movement
  inoremap <c-k> <up>
  inoremap <c-j> <down>
  inoremap <c-h> <left>
  inoremap <c-l> <right>

  " buffer operations
  nnoremap <leader>q :bdelete<CR>
  nnoremap <leader>bd :bdelete<CR>
  nnoremap <leader>bb :Clap buffers<CR>
  " Switch between the last two buffers
  nnoremap <leader><tab> <c-^>

  nnoremap <M-s> :w<CR>

  " Clear highlighted search
  nnoremap <leader>th :nohl<CR>
  " Toggle relative/normal line numbering
  nnoremap <leader>tl :set rnu!<CR>

" }}}

" Custom key mappings  ------------------------------------------------------{{{

  " Move (and reindent) selected lines up/down
  vnoremap J :m '>+1<CR>gv=gv
  vnoremap K :m '<-2<CR>gv=gv

" }}}

" Plugin settings  ----------------------------------------------------------{{{

  " TMUX navigator  ---------------------------------------------------------{{{

  nnoremap <silent> <c-w><c-h> :TmuxNavigateLeft<CR>
  nnoremap <silent> <c-w>h :TmuxNavigateLeft<CR>
  nnoremap <silent> <c-w><c-j> :TmuxNavigateDown<CR>
  nnoremap <silent> <c-w>j :TmuxNavigateDown<CR>
  nnoremap <silent> <c-w><c-k> :TmuxNavigateUp<CR>
  nnoremap <silent> <c-w>k :TmuxNavigateUp<CR>
  nnoremap <silent> <c-w><c-l> :TmuxNavigateRight<CR>
  nnoremap <silent> <c-w>l :TmuxNavigateRight<CR>

  " }}}

  " Airline  ----------------------------------------------------------------{{{

  let g:airline#extensions#tabline#enabled=1
  let g:airline#extensions#tabline#fnamemod=':t'
  let g:airline#extensions#tabline#buffer_idx_mode=1
  let g:airline_powerline_fonts=1

  let g:airline#extensions#tabline#buffer_idx_format={
        \ '0': '0 ',
        \ '1': '1 ',
        \ '2': '2 ',
        \ '3': '3 ',
        \ '4': '4 ',
        \ '5': '5 ',
        \ '6': '6 ',
        \ '7': '7 ',
        \ '8': '8 ',
        \ '9': '9 ',
        \}

  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9

  " }}}

  " NERDTree  ---------------------------------------------------------------{{{

  nnoremap <M-e>     :NERDTreeFind<CR>
  nmap     <leader>E :NERDTreeToggle<CR>
  nmap     <leader>e :NERDTreeFind<CR>

  let g:NERDTreeWinSize=45
  let g:NERDTreeQuitOnOpen=1
  let g:NERDTreeAutoDeleteBuffer=1
  let NERDTreeMinimalUI=1
  let NERDTreeDirArrows=1
  let g:WebDevIconsOS='Darwin'

  " }}}


  " Treesitter  -------------------------------------------------------------{{{
lua <<EOF
    require'nvim-treesitter.configs'.setup {
      ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
      -- ignore_install = { "javascript" }, -- List of parsers to ignore installing
      highlight = {
          enable = true,              -- false will disable the whole extension
          -- disable = { "c", "rust" },  -- list of language that will be disabled
      },
      incremental_selection = {
          enable = true,
      },
      indent = {
          enable = true,
      },
    }
EOF
  "}}}

  " Telescope  --------------------------------------------------------------{{{

  nnoremap <leader>ff <cmd>Telescope find_files theme=ivy<cr>
  nnoremap <leader>fg <cmd>Telescope live_grep theme=dropdown<cr>
  nnoremap <leader>fb <cmd>Telescope buffers theme=cursor<cr>
  nnoremap <leader>fh <cmd>Telescope help_tags theme=dropdown<cr>

  " nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_ivy({}))<cr>
  " nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep(require('telescope.themes').get_dropdown({}))<cr>
  " nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown({}))<cr>
  " nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags(require('telescope.themes').get_dropdown({}))<cr>

  " }}}

" }}}

" Language specific  --------------------------------------------------------{{{

  " Go  ---------------------------------------------------------------------{{{

  au FileType go set shiftwidth=4 softtabstop=4 tabstop=4

  let g:go_highlight_build_constraints = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_types = 1

  let g:go_auto_sameids = 1

  let g:gofmt_command = "goimports"
  let g:go_auto_type_info = 1

  let g:go_code_completion_enabled = 1
  let g:go_fmt_autosave = 1
  let g:go_addtags_transform = "camelcase"

  let g:go_metalinter_autosave = 1
  let g:go_metalinter_autosave_enabled = ['vet', 'golint']

  "}}}

  " Rust  -------------------------------------------------------------------{{{

  let g:racer_cmd = "/home/tuomo/.cargo/bin/racer"

  augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
  augroup END

  "}}}

"}}}

"vim:foldmethod=marker
