-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymaps = vim.api.nvim_set_keymap

-- copy file path to clipboard
keymaps("n", "<leader>cp", [[:let @+ = expand('%:p')<CR>]], { noremap = true, silent = true, desc = "Copy file path" })

-- copy relative path to clipboard
keymaps(
  "n",
  "<Leader>cP",
  [[:let @+ = expand('%:p:~:~')<CR>]],
  { noremap = true, silent = true, desc = "Copy relative file path" }
)

keymaps(
  "n",
  "<Leader>Cl",
  [[:let @a = expand('<cword>')<CR>"ayiwOconsole.log('<C-R>a:', <C-R>a);<Esc>]],
  { noremap = true, silent = true, desc = "Insert console.log with variable" }
)

keymaps(
  "x",
  "<Leader>Cl",
  [[:<C-U>let @a = expand('<cword>')<CR>"ayOconsole.log('<C-R>a:', <C-R>a);<Esc>]],
  { noremap = true, silent = true, desc = "Insert console.log with selected text" }
)

keymaps("x", "p", [["_dP]], { noremap = true, silent = true, desc = "Paste without yanking" })
