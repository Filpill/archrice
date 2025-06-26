-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--

-- Compile and View LaTeX PDF
vim.api.nvim_create_autocmd("FileType", {
    pattern = "tex",
    callback = function()
        -- Compile LaTeX with <leader><F1>
        vim.keymap.set("n", "<leader><F11>", ":!pdflatex %:p<CR>", { buffer = true, desc = "Compile LaTeX" })

        -- Open PDF in Zathura with <leader><F2>
        vim.keymap.set("n", "<leader><F12>", ":!zathura --fork %:r.pdf<CR>", { buffer = true, desc = "Open PDF" })
    end,
})

-- Copy paste to X11 Clipboard
vim.keymap.set("v", "<leader><F6>", ":!xclip -f -sel clip<CR>", { desc = "Copy to X11 clipboard" })
vim.keymap.set("n", "<leader><F7>", "mz:-1r !xclip -o -sel clip<CR>", { desc = "Paste from X11 clipboard" })
