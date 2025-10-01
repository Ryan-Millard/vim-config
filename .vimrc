function! CopyAllBuffersToClipboard()
    let l:all_content = ''
    for buf in range(1, bufnr('$'))
        if bufloaded(buf)
            let l:all_content .= join(getbufline(buf, 1, '$'), "\n") . "\n"
        endif
    endfor
    call system('clip.exe', l:all_content)
endfunction

" Set the leader character (See <Leader> uses below)
let mapleader = "\\"

set backspace=indent,eol,start	" Fix backspace issue on certain Windows systems
								" Should not affect Linux as this is how the
								" btn should function

set number	" Add line numbers
set relativenumber	" Line Numbers relative to cursor
			" Aids with navigation
set tabstop=4	" Tab characters = 4 spaces
set shiftwidth=4
set autoindent	" Automatically indent on "="
set smartindent	" Indents based on context
syntax enable	" Enables syntax highlighting using file extension
set list listchars=tab:▸\ ,trail:·	" Tabs show as "▸",	spaces at EOL show up as "·" 
set cursorline	" Highlight the line where the cursor is
set incsearch	" Use incremental searching for characters ("/" in normal mode)
set showmatch	" Show matches based on searches
" set directory=~/.vim/swap//	" set the directory for .swp files to be found easily
set ruler
set statusline+=%F\ %p%%\ %l:%c\ %L	" Display file status at bottom of screen
set nowrap	" Prevent lines from wrapping when text exceeds the screen limit
			" Instead, it overflows to a non-visible area
filetype plugin on

" Enable system clipboard for copy and paste (WSL 2)
" Copy entire file
	nnoremap <Leader>ya :<C-u>silent! w !clip.exe<CR>:redraw!<CR>	

" Silent Vim (disable Vim's error bell)
	set noerrorbells
	set vb
	set t_vb=
	set belloff=all




" --------------------------------------------------------------------------------------------------------------------
" 				PLUGINS (using VimPlug)
" --------------------------------------------------------------------------------------------------------------------
" All Lazy Loads improve performance as Vim is single-threaded
call plug#begin('~/.vim/plugged')

		" NERDTree (Lazy Load)
			Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
					" NERDTree map in 'n' mode
						" Open file tree on RHS of screen
						nnoremap <Leader>d :NERDTreeToggle<CR>
					" File Explorer, open with '\ex'
						" Similar to :Ex to open netrw
						nnoremap <Leader>ex :tabe \| NERDTree \| only<CR>

		" vim-airline for a prettier status bar
			Plug 'vim-airline/vim-airline'

		" Emmet-vim plugin auto-complete for HTML tags
			Plug 'mattn/emmet-vim'
					" trigger using 'Ctrl-e'
					imap <C-e> <C-o>:call emmet#expandAbbr(0, "i")<CR>

        " NerdCommenter (Lazy Load)
			" Allows for commenting from n & v modes
			Plug 'preservim/nerdcommenter'
					" Add space after comment char, e.g.: // Comment
					let g:NERDSpaceDelims = 1
					" Enable NERDCommenterToggle to check if all selected lines are commented out or not
					let g:NERDToggleCheckAllLines = 1
					" Map to "\\" for comment toggling
					nmap <Leader><Leader> <Plug>NERDCommenterToggle
					vmap <Leader><Leader> <Plug>NERDCommenterToggle
			" In n & v mode:
				" '\\' toggles comments
				" '\cc' comments entire line
				" '\cu' uncomments entire line
			" See NERDCommenter docs for more info

        " Tagbar (Lazy Load) - on LHS of screen
			Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
					" Map '\t' to toggle Tagbar visibility
					nnoremap <Leader>t :TagbarToggle<CR>
					" Set the Tagbar window width
					let g:tagbar_width = 30
		"
        " Vim Surround
	  " Use 'S' from n & v modes to surround the selection in your chosen char
			Plug 'tpope/vim-surround'

		" Kotlin syntax plugin
		Plug 'udalov/kotlin-vim'

call plug#end()
