-- Open/copy GitHub (or GitLab/Bitbucket/etc.) URLs for the current file/line.
-- https://github.com/ruifm/gitlinker.nvim
return {
  'ruifm/gitlinker.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    -- Copy URL to clipboard (normal: current line; visual: line range)
    {
      '<leader>gy',
      function() require('gitlinker').get_buf_range_url 'n' end,
      desc = '[G]it: [Y]ank GitHub URL',
      silent = true,
    },
    {
      '<leader>gy',
      function() require('gitlinker').get_buf_range_url 'v' end,
      mode = 'v',
      desc = '[G]it: [Y]ank GitHub URL',
      silent = true,
    },
    -- Open in browser
    {
      '<leader>go',
      function()
        require('gitlinker').get_buf_range_url('n', {
          action_callback = require('gitlinker.actions').open_in_browser,
        })
      end,
      desc = '[G]it: [O]pen file in browser',
      silent = true,
    },
    {
      '<leader>go',
      function()
        require('gitlinker').get_buf_range_url('v', {
          action_callback = require('gitlinker.actions').open_in_browser,
        })
      end,
      mode = 'v',
      desc = '[G]it: [O]pen file in browser',
      silent = true,
    },
    -- Open current file on the main branch (no line numbers) in browser
    {
      '<leader>gm',
      function()
        local function sh(cmd)
          local out = vim.fn.systemlist(cmd)
          if vim.v.shell_error ~= 0 then return nil end
          return out[1]
        end

        local file = vim.fn.expand '%:p'
        if file == '' then
          vim.notify('No file in current buffer', vim.log.levels.WARN)
          return
        end
        local dir = vim.fn.fnamemodify(file, ':h')

        local toplevel = sh('git -C ' .. vim.fn.shellescape(dir) .. ' rev-parse --show-toplevel')
        local remote = sh('git -C ' .. vim.fn.shellescape(dir) .. ' remote get-url origin')
        if not toplevel or not remote then
          vim.notify('Not in a git repo with an origin remote', vim.log.levels.WARN)
          return
        end

        -- Pick a default branch: prefer 'main', fall back to 'master'.
        local branch = 'main'
        if not sh('git -C ' .. vim.fn.shellescape(dir) .. ' show-ref --verify --quiet refs/remotes/origin/main && echo ok') then
          if sh('git -C ' .. vim.fn.shellescape(dir) .. ' show-ref --verify --quiet refs/remotes/origin/master && echo ok') then
            branch = 'master'
          end
        end

        -- Normalize remote URL -> https://host/owner/repo
        local host, path = remote:match '^git@([^:]+):(.+)$'
        if not host then
          host, path = remote:match '^https?://([^/]+)/(.+)$'
        end
        if not host then
          host, path = remote:match '^ssh://git@([^/]+)/(.+)$'
        end
        if not host then
          vim.notify('Could not parse remote: ' .. remote, vim.log.levels.WARN)
          return
        end
        path = path:gsub('%.git$', '')

        local rel = file:sub(#toplevel + 2) -- strip toplevel + '/'
        local url = string.format('https://%s/%s/blob/%s/%s', host, path, branch, rel)

        vim.fn.setreg('+', url)
        vim.notify('Opening ' .. url)
        local opener = (vim.fn.has 'mac' == 1) and 'open' or (vim.fn.has 'wsl' == 1 and 'wslview' or 'xdg-open')
        vim.fn.jobstart({ opener, url }, { detach = true })
      end,
      desc = '[G]it: open file on [m]ain branch in browser',
      silent = true,
    },
    -- Open repo root in browser
    {
      '<leader>gB',
      function()
        require('gitlinker').get_repo_url {
          action_callback = require('gitlinker.actions').open_in_browser,
        }
      end,
      desc = '[G]it: open repo in [B]rowser',
      silent = true,
    },
  },
  opts = {
    mappings = nil, -- disable default <leader>gy mapping; we define our own
  },
}
