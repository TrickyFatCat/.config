def --wrapped notes [...args] {
  let dir: path = pwd;
  let notes_dir: path = "~/Documents/Notes/"
  cd $notes_dir;
  kitten @launch --type=tab --cwd=current --title="Notes" $env.EDITOR ...$args
  cd $dir;
}

def icat [image?: path,
  --all (-a): string] {

  if not ($all | is-empty) {
    let images = (glob $all)

    if ($images | is-empty) {
      print $"Can't find any ($all) images in this directory"
      return
    }
    kitten icat ...$images
    return
  }

  if ($image | is-empty) or not ($image | path exists) {
    print $"Invalid path to image"
    return
  }

  kitten icat $image
}

def --wrapped cat [...args]  {
  open ...$args | lines
}
