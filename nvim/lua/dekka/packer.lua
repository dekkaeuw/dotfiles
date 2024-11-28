-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  if packer_bootstrap then
    require('packer').sync()
  end

  use {'nvim-telescope/telescope.nvim', tag = '0.1.8',
	-- or                            , branch = '0.1.x',
  	requires = { {'nvim-lua/plenary.nvim'} }
  }
  if packer_bootstrap then
    require('packer').sync()
  end

  use {'morhetz/gruvbox', config = function() vim.cmd.colorscheme("gruvbox") end }
  if packer_bootstrap then
    require('packer').sync()
  end

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  if packer_bootstrap then
    require('packer').sync()
  end
end)
