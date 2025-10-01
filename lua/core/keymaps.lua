local map = vim.keymap.set
local nvim_create_user_command = vim.api.nvim_create_user_command

-- Copy file to clipboard
map("n", "<Leader>ya", [[:%w !clip.exe<CR>:redraw!<CR>]], { silent = true })

-- Lazy copy all buffers to Windows clipboard (WSL2)
local function copy_buffers()
  local content = {}
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(b) then
      vim.list_extend(content, vim.api.nvim_buf_get_lines(b, 0, -1, false))
      table.insert(content, "") -- separate buffers
    end
  end
  vim.fn.system("clip.exe", table.concat(content, "\n"))
  print("Copied all buffers to Windows clipboard!")
end

map("n", "<leader>cab", copy_buffers, { noremap = true, silent = true })

nvim_create_user_command("CopyAllBuffersToClipboard", copy_buffers, {})
