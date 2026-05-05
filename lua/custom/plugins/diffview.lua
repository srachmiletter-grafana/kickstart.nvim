-- PR-review-style diff UI.
-- https://github.com/sindrets/diffview.nvim
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
  keys = {
    -- Diff working tree vs index (your unstaged changes)
    {
      '<leader>gd',
      '<cmd>DiffviewOpen<cr>',
      desc = '[G]it: [d]iff working tree vs index',
    },
    -- Diff current branch vs main (PR-style review).
    -- Uses origin/main if it exists, else local main, else master.
    {
      '<leader>gD',
      function()
        local function has_ref(ref)
          vim.fn.system { 'git', 'rev-parse', '--verify', '--quiet', ref }
          return vim.v.shell_error == 0
        end
        local base
        if has_ref 'refs/remotes/origin/main' then
          base = 'origin/main'
        elseif has_ref 'refs/heads/main' then
          base = 'main'
        elseif has_ref 'refs/remotes/origin/master' then
          base = 'origin/master'
        elseif has_ref 'refs/heads/master' then
          base = 'master'
        else
          vim.notify('Could not find main or master branch', vim.log.levels.WARN)
          return
        end
        vim.cmd('DiffviewOpen ' .. base .. '...HEAD')
      end,
      desc = '[G]it: [D]iff branch vs main (PR review)',
    },
    -- File history of the current file
    {
      '<leader>gh',
      '<cmd>DiffviewFileHistory %<cr>',
      desc = '[G]it: file [h]istory',
    },
    -- Close diffview (handy when one is already open)
    {
      '<leader>gc',
      '<cmd>DiffviewClose<cr>',
      desc = '[G]it: [c]lose diffview',
    },
  },
  opts = {
    enhanced_diff_hl = true, -- nicer highlighting for word-level changes within a line
    view = {
      merge_tool = {
        layout = 'diff3_mixed', -- 3-way merge view when resolving conflicts
      },
    },
  },
}
