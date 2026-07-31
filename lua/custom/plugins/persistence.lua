-- Per-cwd session persistence. Restores buffers, window layout, marks, and
-- jumplist so closing nvim isn't a reset button. Sessions are saved
-- automatically on exit; load explicitly with the mappings below.
-- https://github.com/folke/persistence.nvim
---@module 'lazy'
---@type LazySpec
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  ---@module 'persistence'
  ---@type Persistence.Config
  opts = {},
  keys = {
    { '<leader>qs', function() require('persistence').load() end,                desc = 'Session: restore for cwd' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Session: restore last' },
    { '<leader>qd', function() require('persistence').stop() end,                desc = 'Session: don\'t save on exit' },
    { '<leader>qS', function() require('persistence').select() end,              desc = 'Session: [S]elect' },
  },
}
