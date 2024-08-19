vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

-- general settings
vim.o.scrolloff = 9999
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-f>", ":/", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "yy", ":!yabai -m space --layout bsp<cr><cr>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "yff", ":!yabai -m space --layout float<cr><cr>", { noremap = true, silent = false })

-- Automatically change the working directory to the directory of the current file
vim.cmd [[
  augroup AutoChdir
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
  augroup END
]]

vim.schedule(function()
  require "mappings"
end)
