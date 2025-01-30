def icat [picture: path] {
  kitten icat $picture
}

def q [] {
  exit
}

def --wrapped vim [...args] {
  nvim ...$args
}

def --wrapped check [...args]  {
  open ...$args | lines
}

def --wrapped notes [...args] {
  let dir: path = pwd;
  let notes_dir: path = "~/Documents/Notes/"
  cd $notes_dir;
  kitten @launch --type=tab --cwd=current --title="Notes" nvim ...$args
  cd $dir;
}
