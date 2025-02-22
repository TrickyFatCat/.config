if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source

if command -vq flatpak
    set -ga fish_user_paths ~/.local/share/flatpak/exports/bin /var/lib/flatpak/exports/bin
    set -gx --path XDG_DATA_DIRS /usr/local/share/ /usr/share/ ~/.local/share/flatpak/exports/share
    for install_dir in (flatpak --installations)
        set -gxa XDG_DATA_DIRS $install_dir/exports/share
    end
end

fish_add_path -g ~/Tools/GodotEngine/bin/
fish_add_path -g ~/Tools/OdinLang/
fish_add_path -g ~/Apps/teamspeak-client/
