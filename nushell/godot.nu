def godot [godot_ver?: float = 4.3, ...args] {
  let godot_command = $"Godot_v($godot_ver)-stable_linux.x86_64"
  ^$godot_command ...$args
}

def gdedit [project_path?: path = "."] {
  let project_file = glob (path | path join *.godot)

  if ($project_file | is-empty) {
    print "Can't find project.godot file"
    return
  }

  mut project_name = (cat ($project_file | get 0) | filter {str contains "config/name="} | get 0)
 
  mut first_index: int = ($project_name | str index-of '"')
  mut last_index: int = ($project_name | str length)
  $project_name = ($project_name | str substring $first_index..$last_index | str trim -c '"')

  mut godot_ver = (open ($project_file | get 0) | lines | find config/features | get 0)
  $first_index = ($godot_ver | str index-of '"')
  $last_index = ($godot_ver | str index-of ',')
  $godot_ver = ($godot_ver | str substring $first_index..$last_index | str trim -c '"' | str trim -c ',' | str trim -r -c '"')
  print $godot_ver

  print $"Opening ($project_name) via Godot ($godot_ver)"

  let current_dir = pwd
  cd $project_path

  let editor_command: string = $"Godot_v($godot_ver)-stable_linux.x86_64"
  kitten @launch --type=tab --dont-take-focus --cwd=current --title=$"Editor ($project_name)" $editor_command -e --path $project_path

  kitten @launch --type=tab --dont-take-focus --cwd=current --title=$"Src ($project_name)" $env.EDITOR

  if (ls -a | where name == .git | is-not-empty) {
    kitten @launch --type=tab --dont-take-focus --cwd=current --title=$"Git ($project_name)" lazygit
  }

  cd $current_dir

  kitten @focus-tab --match cmdline:nvim
}
