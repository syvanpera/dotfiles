if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish --disable-up-arrow | source
end

set -U fish_greeting

# opencode
fish_add_path /home/tuomo/.opencode/bin
