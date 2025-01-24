def --wrapped godot [...args] {
  Godot_v4.3-stable_linux.x86_64 ...$args
}

def gdedit [project_path: path = "."] {
  let project_file = ls $project_path | find project.godot | get name

  if ($project_file | is-empty) {
    print "Can't find project.godot file"
    return
  }

  mut project_name = (open ($project_file | get 0) | lines | filter {str contains "config/name="} | get 0)
 
  let first_index: int = ($project_name | str index-of `"`)
  let last_index: int = ($project_name | str length)
  $project_name = ($project_name | str substring $first_index..$last_index | str trim -c '"')

  print ("Open " | append $project_name | str join)

  let current_dir = pwd
  cd $project_path

  let editor_title: string = ("Editor: " | append $project_name | str join "")
  kitten @launch --type=tab --dont-take-focus --cwd=current --title=($editor_title) Godot_v4.3-stable_linux.x86_64 -e --path $project_path

  let scripts_title: string = ("Scripts: " | append $project_name | str join "")
  kitten @launch --type=tab --dont-take-focus --cwd=current --title=($scripts_title) nvim

  let git_folder = ls -a | find .git | where type == dir

  if ($git_folder | is-not-empty) {
    let git_title: string = ("Git: " | append $project_name | str join "")
    kitten @launch --type=tab --dont-take-focus --cwd=current --title=($git_title) lazygit
  }

  cd $current_dir

  kitten @focus-tab --match cmdline:nvim
}
