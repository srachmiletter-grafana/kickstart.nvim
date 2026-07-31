-- Frecency-sorted file picker via Telescope. Recently/frequently used files
-- float to the top, so in a large monorepo you rarely type more than a few
-- chars to reach a file you've touched before. Persists across sessions.
-- https://github.com/danielfalk/smart-open.nvim
---@module 'lazy'
---@type LazySpec
return {
  'danielfalk/smart-open.nvim',
  branch = '0.2.x',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    { 'kkharji/sqlite.lua' },
    -- Optional but recommended: better matching + frecency history
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
  cmd = 'Telescope',
  keys = {
    -- Suggested (not implemented — pick what you want):
    -- { '<leader>sf', function() require('telescope').extensions.smart_open.smart_open() end, desc = '[S]earch [F]iles (frecency)' },
    -- Or shadow kickstart's <leader>sf to use frecency instead of plain find_files.
  },
  config = function()
    require('telescope').load_extension 'smart_open'
  end,
}
