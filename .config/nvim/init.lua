require "core"

local custom_init_path = vim.api.nvim_get_runtime_file("lua/custom/init.lua", false)[1]

if custom_init_path then
  dofile(custom_init_path)
end

require("core.utils").load_mappings()

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

-- bootstrap lazy.nvim!
if not vim.loop.fs_stat(lazypath) then
  require("core.bootstrap").gen_chadrc_template()
  require("core.bootstrap").lazy(lazypath)
end

dofile(vim.g.base46_cache .. "defaults")
vim.opt.rtp:prepend(lazypath)
require "plugins"

-- general settings
vim.o.scrolloff = 9999
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':/', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', 'yy', ':!yabai -m space --layout bsp<cr><cr>', { noremap = true, silent = false })
vim.api.nvim_set_keymap('n', 'yff', ':!yabai -m space --layout float<cr><cr>', { noremap = true, silent = false })

-- FULLSCREEN SHORTCUT FOR TOGGLETERM
-- Define a variable to store the fullscreen toggle state
vim.g.term_fullscreen = false

-- Define a function to toggle the terminal size
function _G.toggle_terminal_fullscreen()
    local term = require('toggleterm.terminal').get(1) -- Get the existing terminal
    if vim.g.term_fullscreen then
        term:resize(20) -- Resize to default size when toggling off
    else
        term:resize(vim.o.lines - 3) -- Resize to almost full screen when toggling on
    end
    vim.g.term_fullscreen = not vim.g.term_fullscreen -- Toggle the state
end

-- Map the function to a keybinding
vim.api.nvim_set_keymap('n', '<C-t>', ':lua toggle_terminal_fullscreen()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n>:lua toggle_terminal_fullscreen()<CR>', { noremap = true, silent = true })

-- NEOVIM REMOTE TO SYNC NVIM
-- Function to open the current file in the main Neovim instance
function _G.open_file_in_main_instance()
    local file = vim.fn.expand("%:p")
    if vim.fn.has("nvim") then
        os.execute("nvr --remote-silent " .. vim.fn.shellescape(file))
    else
        os.execute("nvr --remote-silent " .. file)
    end
end

-- Normal mode mapping
vim.api.nvim_set_keymap('n', '<leader>o', ':lua open_file_in_main_instance()<CR>', { noremap = true, silent = true })

-- Terminal mode mapping to open the current file in the main Neovim instance
vim.api.nvim_set_keymap('t', '<C-o>', '<C-\\><C-n>:lua open_file_in_main_instance()<CR>:ToggleTerm direction=float<CR>', { noremap = true, silent = true })

-- OPEN TOGGLETERM IN CURRENT DIR
-- Function to open toggle-term with the directory of the current file
function _G.open_toggle_term_with_file_directory()
    local current_dir = vim.fn.expand('%:p:h')
    vim.api.nvim_command('ToggleTerm direction=horizontal dir=' .. current_dir)
end

-- Mapping to open toggle-term in the current file's directory
vim.api.nvim_set_keymap('n', '<leader>tt', ':lua open_toggle_term_with_file_directory()<CR>', { noremap = true, silent = true })

-- Automatically change the working directory to the directory of the current file
vim.cmd([[
  augroup AutoChdir
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
  augroup END
]])
