-- Extend the base gitsigns spec (defined in init.lua / kickstart) with extra opts.
-- lazy.nvim merges specs that share the same plugin key.

---@module 'lazy'
---@type LazySpec
return {
  'lewis6991/gitsigns.nvim',
  ---@module 'gitsigns'
  ---@type Gitsigns.Config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    current_line_blame = true,
    current_line_blame_opts = {
      delay = 300,
      virt_text_pos = 'right_align',
    },
    -- format: <author>, <relative time> · <summary>
    current_line_blame_formatter = '<author>, <author_time:%R> · <summary>',
  },
  keys = {
    { '<leader>gb', function() require('gitsigns').toggle_current_line_blame() end, desc = 'Toggle inline git [b]lame' },
  },
}
