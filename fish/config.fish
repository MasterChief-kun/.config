if status is-interactive
    # Commands to run in interactive sessions can go here
end

neofetch
fish_add_path /home/rohanj/bin
fish_add_path ~/.emacs.d/bin
fish_add_path /home/rohanj/.config/rofi/scripts/
fish_add_path /home/rohanj/miniconda3/condabin

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/rohanj/miniconda3/bin/conda
    eval /home/rohanj/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

