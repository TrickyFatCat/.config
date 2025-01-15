# Opens Godot Engine in current directory 
# If it doesn't have project file (*.godot) it will open project manager
# Overwise the it will open project editor
function godot --wraps=Godot_v4.3-stable_linux.x86_64 --description 'alias godot=Godot_v4.3.x86_64'
    Godot_v4.3-stable_linux.x86_64 -e $argv
end

# Opens Godots tool
# Requires Godots
function godots --wraps='flatpak run io.github.MakovWait.Godots' --description 'alias godots=flatpak run io.github.MakovWait.Godots'
    flatpak run io.github.MakovWait.Godots $argv
end

# Opens project, external text editor and git client of choice using for project
# Run gdedit <path_to_project_directory
# For example gdedit ~/Projects/MyGodotGame
# You can runt this command without path, then it will use current directorry
#
# You need Kitty terminal to run this command
function gdedit
    set -l godot Godot_v4.3-stable_linux.x86_64
    set -l editor nvim
    set -l git_client lazygit

    # Checks if path to project directory was given
    if begin
            test (count $argv) -gt 0; and test -d $argv[1]
        end
        set project_path $argv
    else
        # If not, it will use current directory
        set project_path "."
    end

    # Gets porject files in the directory
    set -l project_file $project_path/*.godot

    if test (count $project_file) -gt 0
        pushd $project_path

        set -l project_name (basename $project_file .godot)

        # Creates a new Kitty tab and runst text editor
        kitten @launch --type=tab --dont-take-focus --cwd=current --title=$project_name $editor

        # If directory is a repository. Then creates new Kitty tab and runs git client
        if test (count .git) -gt 0
            kitten @launch --type=tab --dont-take-focus --cwd=current --title="Git" $git_client
        end
        # Creates a new Kitty tab and runs Godot
        kitten @launch --type=tab --dont-take-focus --cwd=current --title="Godot" $godot -e --path $PWD

        popd

        # Focus text editor tab
        kitten @focus-tab --match cmdline:$editor
    else
        echo "Directory isn't a godot project"
    end
end
