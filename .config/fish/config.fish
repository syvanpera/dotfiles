set -gx EDITOR nvim

if status is-interactive
    # Commands to run in interactive sessions can go here
    atuin init fish --disable-up-arrow | source
end
# fzf_configure_bindings --directory=f
