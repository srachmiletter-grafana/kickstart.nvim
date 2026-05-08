# Leader keymaps

Leader is `<Space>`. This is a reference for every `<leader>*` mapping
defined in this config. Source files are linked so it's easy to jump in
and tweak.

Groups (registered with `which-key` in `init.lua`):

- `<leader>s` — **[S]earch** (n, v)
- `<leader>t` — **[T]oggle**
- `<leader>h` — **Git [H]unk** (n, v)
- `<leader>g` — Git (custom; see below)
- `<leader>c` — Misc copy actions

---

## Top-level

| Keys              | Mode | Action                                    | Source            |
| ----------------- | ---- | ----------------------------------------- | ----------------- |
| `<leader><leader>`| n    | Find existing buffers (Telescope)         | `init.lua`        |
| `<leader>/`       | n    | Fuzzily search in current buffer          | `init.lua`        |
| `<leader>q`       | n    | Open diagnostic [Q]uickfix list           | `init.lua`        |
| `<leader>f`       | n, v | [F]ormat buffer (conform.nvim)            | `init.lua`        |
| `<leader>b`       | n    | Debug: Toggle Breakpoint                  | `kickstart/plugins/debug.lua` |
| `<leader>B`       | n    | Debug: Set conditional Breakpoint         | `kickstart/plugins/debug.lua` |

## `<leader>s` — Search (Telescope)

All defined in `init.lua`.

| Keys          | Mode | Action                                              |
| ------------- | ---- | --------------------------------------------------- |
| `<leader>sh`  | n    | [S]earch [H]elp                                     |
| `<leader>sk`  | n    | [S]earch [K]eymaps                                  |
| `<leader>sf`  | n    | [S]earch [F]iles                                    |
| `<leader>sF`  | n    | [S]earch [F]iles (incl. hidden/ignored)             |
| `<leader>ss`  | n    | [S]earch [S]elect Telescope pickers                 |
| `<leader>sw`  | n, v | [S]earch current [W]ord                             |
| `<leader>sg`  | n    | [S]earch by [G]rep (live grep)                      |
| `<leader>s/`  | n    | [S]earch by grep in open files                      |
| `<leader>sd`  | n    | [S]earch [D]iagnostics                              |
| `<leader>sr`  | n    | [S]earch [R]esume                                   |
| `<leader>s.`  | n    | [S]earch recent files (oldfiles)                    |
| `<leader>sc`  | n    | [S]earch [C]ommands                                 |
| `<leader>sn`  | n    | [S]earch [N]eovim config files                      |

## `<leader>t` — Toggle

| Keys          | Mode | Action                                | Source                              |
| ------------- | ---- | ------------------------------------- | ----------------------------------- |
| `<leader>th`  | n    | [T]oggle inlay [H]ints (LSP)          | `init.lua` (LspAttach)              |
| `<leader>tb`  | n    | [T]oggle git [b]lame line             | `kickstart/plugins/gitsigns.lua`    |
| `<leader>tw`  | n    | [T]oggle git intra-line [w]ord diff   | `kickstart/plugins/gitsigns.lua`    |

## `<leader>h` — Git hunks (gitsigns)

All defined in `kickstart/plugins/gitsigns.lua`.

| Keys          | Mode | Action                                                     |
| ------------- | ---- | ---------------------------------------------------------- |
| `<leader>hs`  | n, v | git [s]tage hunk                                           |
| `<leader>hr`  | n, v | git [r]eset hunk                                           |
| `<leader>hS`  | n    | git [S]tage buffer                                         |
| `<leader>hR`  | n    | git [R]eset buffer                                         |
| `<leader>hp`  | n    | git [p]review hunk                                         |
| `<leader>hi`  | n    | git preview hunk [i]nline                                  |
| `<leader>hb`  | n    | git [b]lame line (full)                                    |
| `<leader>hd`  | n    | git [d]iff against index                                   |
| `<leader>hD`  | n    | git [D]iff against last commit                             |
| `<leader>hq`  | n    | git hunk [q]uickfix list (this file)                       |
| `<leader>hQ`  | n    | git hunk [Q]uickfix list (all files in repo)               |

## `<leader>g` — Git (gitlinker + diffview)

| Keys          | Mode | Action                                          | Source                         |
| ------------- | ---- | ----------------------------------------------- | ------------------------------ |
| `<leader>gy`  | n, v | [Y]ank GitHub URL for current line/range        | `custom/plugins/gitlinker.lua` |
| `<leader>go`  | n, v | [O]pen current file/line in browser             | `custom/plugins/gitlinker.lua` |
| `<leader>gm`  | n    | Open file on [m]ain branch in browser           | `custom/plugins/gitlinker.lua` |
| `<leader>gB`  | n    | Open repo in [B]rowser                          | `custom/plugins/gitlinker.lua` |
| `<leader>gd`  | n    | [d]iff working tree vs index (Diffview)         | `custom/plugins/diffview.lua`  |
| `<leader>gD`  | n    | [D]iff branch vs main — PR review (Diffview)    | `custom/plugins/diffview.lua`  |
| `<leader>gh`  | n    | File [h]istory (Diffview)                       | `custom/plugins/diffview.lua`  |
| `<leader>gc`  | n    | [c]lose Diffview                                | `custom/plugins/diffview.lua`  |

## `<leader>c` — Copy / misc

| Keys          | Mode | Action                          | Source              |
| ------------- | ---- | ------------------------------- | ------------------- |
| `<leader>cl`  | n, v | Copy LLM ref to clipboard       | `lua/llm-ref.lua`   |

---

## Notes

- `:Telescope keymaps` (`<leader>sk`) shows the live, current set of
  keymaps and is the source of truth.
- `which-key` will pop up after pressing `<leader>` and pause briefly,
  so you can always discover these interactively.
- When adding a new mapping, register its group prefix in the
  `which-key` spec in `init.lua` if it doesn't already exist, and update
  this file.
