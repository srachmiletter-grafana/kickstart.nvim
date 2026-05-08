-- Copy `@path:line` (or `@path:l1-l2`) reference to clipboard for pasting into an LLM.
-- Path is relative to git root when available, else cwd.

local function git_root()
  local out = vim.fn.systemlist("git -C " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " rev-parse --show-toplevel")
  if vim.v.shell_error ~= 0 or not out[1] then return nil end
  return out[1]
end

local function copy_ref(opts)
  local abs = vim.fn.expand("%:p")
  if abs == "" then
    vim.notify("no file", vim.log.levels.WARN)
    return
  end

  local root = git_root()
  local rel
  if root and abs:sub(1, #root + 1) == root .. "/" then
    rel = abs:sub(#root + 2)
  else
    rel = vim.fn.expand("%:.")
  end

  local ref
  if opts.range == 2 then
    ref = string.format("@%s:%d-%d", rel, opts.line1, opts.line2)
  else
    ref = string.format("@%s:%d", rel, vim.fn.line("."))
  end

  vim.fn.setreg("+", ref)
  vim.notify(ref)
end

vim.api.nvim_create_user_command("LlmRef", copy_ref, { range = true })
vim.keymap.set("n", "<leader>cl", ":LlmRef<CR>", { silent = true, desc = "Copy LLM ref to clipboard" })
vim.keymap.set("v", "<leader>cl", ":LlmRef<CR>", { silent = true, desc = "Copy LLM ref to clipboard" })
