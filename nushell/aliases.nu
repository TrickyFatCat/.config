def icat [picture: path] {
  kitten icat $picture
}

def q [] {
  exit
}

def --wrapped vim [...args] {
  nvim ...$args
}

