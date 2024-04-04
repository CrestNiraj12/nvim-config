# My neovim setup

## Plugins used
1. autopairs - A super powerful autopair plugin for Neovim that supports multiple characters. 
2. barbar - A tabline plugin with re-orderable, auto-sizing, clickable tabs, icons, nice highlighting, sort-by commands and a magic jump-to-buffer mode.
3. tokyonight - A theme package.
4. comments
5. copilot
6. debugger
7. fidget
8. fugitive
9. gitsigns
10. lsp
11. neo-tree
12. telescope
13. tmux-navigator
14. toggleterm
15. treesitter
16. trouble
17. undotree
19. wakatime
20. flutter-tools
21. copilot
22. nvim-surround - To wrap selection with braces
23. git-blame


## Configuration for my nvim setup

```
git clone https://github.com/CrestNiraj12/nvim-config ~/.config/nvim
```

## Sessionizer

```bash
#!/bin/bash

# Original Source
# https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer

selected=$(find ~/projects -mindepth 1 -maxdepth 2 -type d | fzf)

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

# if not inside tmux session, and not running
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

# if outside just attach
if [[ -z $TMUX ]]; then
  tmux attach -t $selected_name
  exit 0
fi

tmux switch-client -t $selected_name
```
