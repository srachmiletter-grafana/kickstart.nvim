-- Extend the base gitsigns spec (defined in init.lua / kickstart) with extra opts.
-- lazy.nvim merges specs that share the same plugin key.
--
-- IMPORTANT: do NOT set `keys`, `cmd`, `event`, `ft` here. The base spec is
-- eager, and adding a lazy trigger via merge would defer gitsigns until that
-- trigger fires — breaking gutter signs and `]c`/`[c` on startup.
--
-- Also: do NOT define `on_attach` here. Lazy.nvim merges opts tables, but
-- function fields overwrite rather than compose, so an `on_attach` here would
-- clobber the one in `lua/kickstart/plugins/gitsigns.lua` (which sets up `]c`,
-- `[c`, and the `<leader>h*` hunk mappings).

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
}
