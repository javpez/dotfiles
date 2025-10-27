" ===================================================================================================================== 
" Vim configuration file.
" - Online documentation: https://vimhelp.org/
" - Offline search for help: :help <word>
" ===================================================================================================================== 

" --------------------------------------------------------------------------------------------------------------------- 
" General settings
" --------------------------------------------------------------------------------------------------------------------- 

" Use Vim settings instead of Vi settings.
" Note: This mus be first. It can change options and packages as side effects.
if &compatible
	set nocompatible
endif

" Show cursor position all the time
set ruler

" Show line numbers
set number

" Time out for key codes
set ttimeout
set ttimeoutlen=100

" Add lines of context around the cursor.
set scrolloff=5

" Do incremental searching
set incsearch

" Highlight search
set hlsearch

" In many terminal emulators the mouse works just fine.
" By enabling it you can position the cursor, visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

" Only do this part when Vim was compiled with the +eval feature.
if 1
  " Put these in an autocmd group, so that you can revert them with:
  " ":autocmd! vimStartup"
  augroup vimStartup
    autocmd!

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler (happens when dropping a file on gvim),
    " for a commit or rebase message (likely a different one than last time), and when using xxd(1) to filter
    " and edit binary files (it transforms input files back and forth, causing them to have dual nature, so to speak)
    " or when running the new tutor
    autocmd BufReadPost *
      \ let line = line("'\"")
      \ | if line >= 1 && line <= line("$") && &filetype !~# 'commit'
      \      && index(['xxd', 'gitrebase', 'tutor'], &filetype) == -1
      \      && !&diff
      \ |   execute "normal! g`\""
      \ | endif

  " Quite a few people accidentally type "q:" instead of ":q" and get confused by the command line window.
  " Give a hint about how to get out. If you don't like this you can put this in your vimrc: ":autocmd! vimHints".
  augroup vimHints
    au!
    autocmd CmdwinEnter *
	  \ echohl Todo |
	  \ echo gettext('You discovered the command-line window! You can close it with ":q".') |
	  \ echohl None
  augroup END
endif

" Switch syntax highlighting on when the terminal has colors or when using the GUI (which always has colors).
" Revert with ":syntax off".
if &t_Co > 2 || has("gui_running")
	syntax on
endif

" Prevent that the langmap option applies to characters that result from a mapping.
" If set (default), this may break plugins (but it's backward compatible).
if has('langmap') && exists('+langremap')
	set nolangremap
endif

" Dont wrap lines
set nowrap

filetype plugin indent on

" --------------------------------------------------------------------------------------------------------------------- 
" Mappings
" --------------------------------------------------------------------------------------------------------------------- 

" Custom leader key
let mapleader = ","

" Use vim-like motions to focus panes (splits).
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" Split window (horizontally)
nmap <silent> <leader>s <c-w>s<CR>
" Split window (vertically)
nmap <silent> <leader>v <c-w>v<CR>
" Maximize current window size
nmap <silent> <leader>E <c-w>\|<c-w>_ <CR>
" Resize windows equally
nmap <silent> <leader>e <c-w>=<CR>
" Close current window
nmap <silent> <leader>q <c-w>q<CR>
" Close all windows except current
nmap <silent> <leader>o <c-w>o<CR>

" --------------------------------------------------------------------------------------------------------------------- 
" Packages
" --------------------------------------------------------------------------------------------------------------------- 

" The matchit plugin makes the % command work better, but it is not backwards compatible.
" The ! means the package won't be loaded right away but when plugins are loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" Remove search highlighting after 4 seconds of idle time or going into insert mode.
packadd nohlsearch

" Briefly highlight the region of the last yank.
packadd hlyank

" --------------------------------------------------------------------------------------------------------------------- 
" Plugins configuration
" --------------------------------------------------------------------------------------------------------------------- 
" - Plugins is a vim package located in ".vim/pack/" and consists on a list of arbitrary vim scripts.
" - Note: Plugins under the ".vim/pack/plugins/start" directory will be automatically loaded during initialization.
" --------------------------------------------------------------------------------------------------------------------- 

" Catpuccin colorscheme (mocha flavour).
set termguicolors
colorscheme catppuccin_mocha

" Status line (lightline).
set laststatus=2
set noshowmode
let g:lightline = {
	\ 'colorscheme' : 'catppuccin_mocha',
	\ }
