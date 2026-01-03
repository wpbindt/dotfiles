local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('rebelot/kanagawa.nvim')

Plug('kyazdani42/nvim-tree.lua')
Plug('kyazdani42/nvim-web-devicons')

Plug('romgrk/barbar.nvim')
Plug('nvim-lualine/lualine.nvim')

Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
Plug('neovim/nvim-lspconfig')

vim.call('plug#end')

home = os.getenv("HOME")
package.path = home .. "/.config/nvim/?.lua;" .. package.path

require "common"
dofile(home .. "/.config/nvim/theme.lua")
require "vimtree"
require "barbar"
-- underscore added for namespace shit
require "lua_line"
require "lsp"
