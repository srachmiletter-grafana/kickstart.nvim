# Neovim config — agent notes

This config is based on **kickstart.nvim** using **lazy.nvim** as the plugin manager.
Leader key is `<Space>`. Colorscheme: `tokyonight-night`.

## Layout

- `init.lua` — kickstart's entry point. **Don't modify** unless explicitly asked.
- `lua/kickstart/` — upstream kickstart modules. **Don't modify.**
- `lua/custom/plugins/` — my plugins live here. **One file per plugin**, named after the plugin (e.g. `render-markdown.lua`, `diffview.lua`).
- `lua/custom/plugins/init.lua` — leave as the kickstart stub; add new plugins as separate files.

## Plugin spec conventions

- Return a single `LazySpec` table from each plugin file.
- Annotate with LuaLS:
  ```lua
  ---@module 'lazy'
  ---@type LazySpec
  return { ... }
  ```
- Lazy-load when reasonable: prefer `ft`, `cmd`, `keys`, or `event` over eager loading.
- Prefer `opts = {}` over `config = function() require(...).setup(...) end` unless real logic is needed.
- Add `---@module` / `---@type` annotations for plugin opts when the plugin provides them.

## Preferences

- Prefer **maintained Lua plugins** over Vimscript.
- Prefer **in-buffer / TUI** solutions over browser/Electron ones
- I use a **Nerd Font** — icons/devicons are fine to enable.
- **Suggest keymaps** when adding plugins or features, but **don't implement them** unless I explicitly ask. List proposals so I can copy what I want.

## Documentation

- `LEADER_KEYMAPS.md` at the repo root catalogs every `<leader>*` mapping.
  When you add, remove, or change a leader keymap, **update this file in
  the same change**. Also register new prefixes in the `which-key` spec
  in `init.lua` if a group doesn't already exist.

## Workflow

- **Never run `:Lazy sync`, `:Lazy install`, `:Mason`, etc. for me** — I'll handle plugin install/update after you edit files.
- When recommending plugins, give 2-4 options with a one-line tradeoff each, then a pick — don't just dump one.
