-- Format file on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "silent! lua vim.lsp.buf.format()"
})
