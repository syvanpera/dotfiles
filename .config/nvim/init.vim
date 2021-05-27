"    ____      _ __        _
"   /  _/___  (_) /__   __(_)___ ___
"   / // __ \/ / __/ | / / / __ `__ \
" _/ // / / / / /__| |/ / / / / / / /
"/___/_/ /_/_/\__(_)___/_/_/ /_/ /_/

" How to setup both YouCompleteMe & CoC (https://www.youtube.com/watch?v=ICU9OEsNiRA
" Easy align: https://github.com/junegunn/vim-easy-align

" Plugins -------------------------------------------------------------------{{{

  if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  call plug#begin()

    " Themes
    Plug 'rakr/vim-one'
    " Plug 'dylanaraps/wal.vim'
    Plug 'arcticicestudio/nord-vim'
    Plug 'mhartington/oceanic-next'
    Plug 'vim-airline/vim-airline-themes'

    " Make navigation between vim & tmux easier
    Plug 'christoomey/vim-tmux-navigator'
    " A nice status bar
    Plug 'vim-airline/vim-airline'
    " Show undo history
    Plug 'mbbill/undotree'
    " Comment anything
    Plug 'tomtom/tcomment_vim'
    " Fuzzywuzzy search
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    " A file system tree explorer
    Plug 'preservim/nerdtree'
    " Color highlighter
    Plug 'norcalli/nvim-colorizer.lua'
    " Colorize parentheses
    Plug 'junegunn/rainbow_parentheses.vim'
    " Intellisense
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Use Ranger inside vim
    " Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    " Plug 'francoiscabrol/ranger.vim'
    " Highlight a unique character in every word on a line
    Plug 'unblevable/quick-scope'
    " Show added, modified and removed lines on sign column
    Plug 'mhinz/vim-signify'
    " Git on steroids
    Plug 'tpope/vim-fugitive'
    " Git commit browser
    Plug 'junegunn/gv.vim'
    " Show a nice start page
    Plug 'mhinz/vim-startify'
    " Emacs org-mode support
    Plug 'jceb/vim-orgmode'
    " Change root directory to project root
    " Plug 'airblade/vim-rooter'
    " Jump around a file like a champ
    Plug 'justinmk/vim-sneak'
    " Golang support
    Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
    " Prisma 2 support
    Plug 'pantharshit00/vim-prisma'

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

  " colorscheme nord
  colorscheme one
  colorscheme OceanicNext
  " colorscheme wal
  let g:airline_theme = 'base16_oceanicnext'
  let g:one_allow_italics = 1

  let g:airline_left_sep = "\ue0b8"
  let g:airline_right_sep = "\ue0ba"

  " Highlighted row
  let g:nord_cursor_line_number_background = 1

  " Uniform status line
  let g:nord_uniform_status_lines = 1

  " Vsplit line
  let g:nord_bold_vertical_split_line = 1

  "Uniform backgroung highlighting
  let g:nord_uniform_diff_background = 1

  " Include bold style for specified syntax
  let g:nord_bold = 0

  " Include italic style for specified syntax
  let g:nord_italic = 0

  " Include underline style for specified syntax
  let g:nord_underline = 0

  highlight Normal guibg=NONE ctermbg=NONE guifg=#e9fffa
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE

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
  nnoremap <leader>bb :Buffers<CR>
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

  " Undotree  ---------------------------------------------------------------{{{

  let g:undotree_WindowLayout=2

  nnoremap <M-u> :UndotreeToggle<CR>

  " }}}

  " FZF  --------------------------------------------------------------------{{{

  nnoremap <leader>bb :Buffers<CR>
  nnoremap <leader>bc :BCommits<CR>
  nnoremap <leader>gc :Commits<CR>
  nnoremap <leader><space> :Files<CR>
  nnoremap <leader>ff :Files<CR>

  nnoremap <M-F> :Rg<CR>

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

  " Colorizer  --------------------------------------------------------------{{{

  luafile $HOME/.config/nvim/lua/plug-colorizer.lua

  " }}}

  " Rainbow parentheses  ----------------------------------------------------{{{

  let g:rainbow#max_level = 16
  let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

  autocmd FileType * RainbowParentheses

  " }}}

  " CoC  --------------------------------------------------------------------{{{

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f <Plug>(coc-format-selected)
  nmap <leader>f <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a <Plug>(coc-codeaction-selected)
  nmap <leader>a <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current line.
  nmap <leader>ac <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf <Plug>(coc-fix-current)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  " nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " " Manage extensions.
  " nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " " Show commands.
  " nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " " Find symbol of current document.
  " nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " " Search workspace symbols.
  " nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " " Do default action for next item.
  " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " " Resume latest coc list.
  " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  " }}}

  " Ranger  -----------------------------------------------------------------{{{

  " Make Ranger replace netrw and be the file explorer
  " let g:rnvimr_ex_enable = 1
  "
  " nmap <space>r :RnvimrToggle<CR>

  " }}}

  " Quickscope  -------------------------------------------------------------{{{

  " Trigger a highlight in the appropriate direction when pressing these keys:
  let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

  highlight QuickScopePrimary guifg='#00C7DF' gui=underline ctermfg=155 cterm=underline
  highlight QuickScopeSecondary guifg='#afff5f' gui=underline ctermfg=81 cterm=underline

  let g:qs_max_chars=150

  " }}}

  " Fugitive  ---------------------------------------------------------------{{{

  nnoremap <leader>gs :Gstatus<CR>

  " }}}

  " Sneak  ------------------------------------------------------------------{{{

  let g:sneak#label = 1
  " case insensitive sneak
  let g:sneak#use_ic_scs = 1
  " immediately move to the next instance of search
  let g:sneak#s_next = 1

  " remap so I can use , and ; with f and t
  map gS <Plug>Sneak_,
  map gs <Plug>Sneak_;

  " Change the colors
  highlight Sneak guifg=black guibg=#00C7DF ctermfg=black ctermbg=cyan
  highlight SneakScope guifg=red guibg=yellow ctermfg=red ctermbg=yellow

  " Cool prompt
  let g:sneak#prompt = ' : '

  " I like quickscope better for this since it keeps me in the scope of a single line
  " map f <Plug>Sneak_f
  " map F <Plug>Sneak_F
  " map t <Plug>Sneak_t
  " map T <Plug>Sneak_T

  " }}}

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

"}}}

"vim:foldmethod=marker

