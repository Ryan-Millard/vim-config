local map = vim.keymap.set

-- Copy file to clipboard
map("n", "<Leader>ya", [[:%w !clip.exe<CR>:redraw!<CR>]], { silent = true })
